import 'dart:developer';

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
                return PrivacyPolicyPage();
              },
            ));
          } else {
            log("kabul etti***");
            await _firestore.collection("User").doc(user.uid).set({
              "userName": user.displayName,
              "email": user.email,
              "seeName": user.displayName,
              "backgroundImage": "",
              "bio": "",
              "id": user.uid,
              "image": "",
              "password": "",
              "isUserPrivacyPolicyAccept": true
            });

            EasyLoading.dismiss();

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
    } catch (error) {
      print(error);
      EasyLoading.dismiss();
      showMessage("Hata Oluştu $error");
      // Hata işleme ekleyin (örneğin, kullanıcıya hata mesajı göstermek için).
    }
  }
}
