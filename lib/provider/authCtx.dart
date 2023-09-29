import 'dart:developer';

import 'package:mindflow/views/registerandlogin/register.dart';
import 'package:mindflow/widgets/showMesages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/User_Model.dart';
import '../model/usermodel.dart';
import '../services/auth.dart';
import '../views/ArticleStart.dart';

class AuthCtx extends ChangeNotifier {
  bool registerLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthServices _authServices = AuthServices();
  AuthServices get authServices => _authServices;
  AuthController() {}

  void register(
      {required String userName,
      required String email,
      required String password,
      required String seeName,
      required BuildContext context}) async {
    log("tıklamıldı* * *");
    EasyLoading.show(status: 'Kayıt Olunuyor...');

    UserModel user = UserModel(
      "",
      "",
      email,
      userName,
      "",
      "",
      "",
      password,
      seeName,
    );

    await authServices
        .createPerson(
      user,
      password,
    )
        .then((value) async {
      print("Buraya geldi");
      notifyListeners();

      // Fluttertoast.showToast(msg: "Kayıt başarılı bir şekilde oluşturuldu..");
      showMessage("Kayıt başarılı bir şekilde oluşturuldu..");
      registerLoading = false;
      notifyListeners();
      EasyLoading.dismiss();

      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleStart(
                    index: 0,
                  )));
    }).catchError((err) {
      registerLoading = false;
      if (err is FirebaseAuthException) {
        if (err.code == 'email-already-in-use') {
          EasyLoading.dismiss();

          Fluttertoast.showToast(msg: 'Bu e-posta adresi zaten kullanılıyor.');
        }
        notifyListeners();
      } else {
        notifyListeners();

        registerLoading = false;
        log("Hata: ${err.toString()}");
        Fluttertoast.showToast(msg: "Hata: ${err.toString()}");
      }
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    EasyLoading.show(status: 'Giriş Yapılıyor...');

    await authServices
        .signIn(
      email,
      password,
    )
        .then((value) {
      print("Buraya geldi");
      Fluttertoast.showToast(msg: "Giriş başarıyla yapıldı");
      EasyLoading.dismiss();

      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleStart(
                    index: 0,
                  )));
    }).catchError((e) {
      // Kullanıcı bulunamazsa, FirebaseAuthException hatası alınır.
      // Bu hatanın türüne ve koduna göre uyarı mesajını özelleştirebilirsiniz.
      if (e is FirebaseAuthException) {
        String errorMessage = "";
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'Kullanıcı bulunamadı. Lütfen kayıt olun.';
            break;
          case 'wrong-password':
            errorMessage = 'Yanlış şifre. Lütfen tekrar deneyin.';
            break;
          default:
            errorMessage = 'Giriş yaparken bir hata oluştu.';
            break;
        }
        // Uyarıyı göstermek veya başka bir işlem yapmak için bu hatayı kullanabilirsiniz.
        EasyLoading.dismiss();
        if (e.code == 'user-not-found') {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Register();
            },
          ));
        }
        Fluttertoast.showToast(msg: errorMessage);
      }
    });
  }

//GetUserModel
  GetUserModel? getUserModel;
  Future<void> getCurrentUser() async {
    // Firebase Authentication ile oturum açmış kullanıcının bilgilerini alın
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Firebase Firestore bağlantısını başlatın
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Kullanıcının UID'sini kullanarak belirli bir belgeyi alın
      DocumentSnapshot userDoc =
          await firestore.collection('User').doc(user.uid).get();

      if (userDoc.exists) {
        // Kullanıcının bilgilerini alın
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        getUserModel = GetUserModel.fromMap(userData);
        // Kullanıcı bilgilerini kullanabilirsiniz
        print('Kullanıcı adı: ${getUserModel!.userName}');
        print('E-posta: ${userData['email']}');
        // Diğer bilgileri burada kullanabilirsiniz

        // notifyListeners(); // Bu bağlamda notifyListeners kullanmanız gereken bir bağlam varsa kullanabilirsiniz.
      } else {
        print('Kullanıcı bulunamadı');
      }
    } else {
      print('Kullanıcı oturumu açmamış');
    }
  }

}

AuthCtx authCtx = AuthCtx();
