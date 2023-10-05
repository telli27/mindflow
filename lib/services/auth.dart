import 'dart:developer';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindflow/widgets/showMesages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/usermodel.dart';
import '../privacyPolicy.dart';
import '../provider/articleCtx.dart';
import '../provider/authCtx.dart';
import '../views/ArticleStart.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu

  Future<User?> createPerson(UserModel userModel, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: userModel.email!, password: password);
    userModel = userModel..id = user.user!.uid;

    await _firestore
        .collection("User")
        .doc(user.user!.uid)
        .set(userModel.toMap());

    return user.user;
  }

  Future<bool> checkUsernameExists(String username) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("User")
        .where("seeName", isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  TextEditingController _userName = TextEditingController();

  Future<void> signInWithGoogle(
      {required BuildContext context,
      required bool isPrivacyPolicyAccepted}) async {
    EasyLoading.show(status: 'Yükleniyor...');

    try {
      // Google ile giriş yap
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount == null) {
        EasyLoading.dismiss();
        return; // Kullanıcı giriş yapmayı iptal etti.
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // Kullanıcı daha önce kaydedilmiş mi kontrol et
        final userDoc = await _firestore.collection("User").doc(user.uid).get();

        if (userDoc.exists) {
          log("kullanıcı kayıt yapmış**");
          print("kullanıcı kayıt yapmış**");
          // Kullanıcı daha önce kaydedilmiş, sadece articleStart sayfasına yönlendir
          EasyLoading.dismiss();
          articleCtx.selectedIndex = 0;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleStart(
                      index: 0,
                    )),
          );
        } else {
          EasyLoading.dismiss();
          log("kullanıcı kayıt yapmamış**");
          print("kullanıcı kayıt yapmamış**");

          // Kullanıcı daha önce kaydedilmemiş, yeni bir kayıt oluştur.
          if (isPrivacyPolicyAccepted == false) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PrivacyPolicyPage(
                  profile: false,
                );
              },
            )).then((value) {});
          } else {
            log("kabul etti***");
            EasyLoading.dismiss();
            dynamic result = await showGeneralDialog(
                context: context,
                barrierLabel: "",
                transitionDuration: Duration(seconds: 1),
                barrierDismissible: false,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return WillPopScope(
                    onWillPop: () {
                      return null!;
                    },
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setStates) {
                      return AlertDialog(
                        title: Text("Kulanıcı adını gir"),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 0, top: 0),
                        content: Container(
                          height: MediaQuery.of(context).size.width * 0.84,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _userName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                  onTap: () async {
                                    // Kullanıcının girdiği kullanıcı adını kontrol et
                                    bool usernameExists =
                                        await checkUsernameExists(
                                            _userName.text);

                                    if (usernameExists) {
                                      // Kullanıcı adı zaten mevcut
                                      print("Kullanıcı adı kayıtlı!");
                                      Fluttertoast.showToast(
                                          msg:
                                              'Bu kullanıcı adı zaten kullanılıyor.\nBaşka bir tane yazın');
                                    } else {
                                      // Kullanıcı adı mevcut değil, veritabanında güncelle
                                      print("Kullanıcı adı güncellendi: ");
                                      // Veritabanında kullanıcı adını güncelleme işlemini burada yapabilirsiniz
                                      Navigator.of(context).pop(true);
                                    }
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors.blue),
                                          child: Center(
                                              child: Text("Kaydet",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)))))),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: InkWell(
                                  onTap: () {
                                    exit(0);
                                  },
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(color: Colors.blue)),
                                    child: Center(
                                      child: Text(
                                        "Vazgeç",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                });
            log("result* * $result");
            if (result == true) {
              await _firestore.collection("User").doc(user.uid).set({
                "userName": user.displayName,
                "email": user.email,
                "seeName": _userName.text,
                "backgroundImage": "",
                "bio": "",
                "id": user.uid,
                "image": "",
                "password": "",
                "rozetId":0,
                "isUserPrivacyPolicyAccept": true
              });

              // articleStart sayfasına yönlendir
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleStart(
                          index: 0,
                        )),
              );
            }
          }
        }
      }
    } catch (error) {
      print(error);
      EasyLoading.dismiss();
      showMessage("Hata Oluştu $error");
      // Hata işleme ekleyin (örneğin, kullanıcıya hata mesajı göstermek için).
    }
  }
}
