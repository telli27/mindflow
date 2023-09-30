import 'dart:developer';

import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/views/registerandlogin/loginandRegister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'services/auth.dart';
import 'views/ArticleStart.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthServices _authServices = AuthServices();
  @override
  void initState() {
    super.initState();
    //  _authServices.signOut();......
    Future.delayed(Duration(seconds: 2), () async {
      if (_auth.currentUser == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => LoginAndRegister())));
      } else {
        bool l = await check();
        if (l == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ArticleStart(
                        index: 0,
                      ))));
        } else {
          log("kayıtlı değill");
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => LoginAndRegister())));
        }
      }
    });
  }

  Future<bool> check() async {
    final userDoc =
        await _firestore.collection("User").doc(_auth.currentUser!.uid).get();
    bool k = userDoc.get("isUserPrivacyPolicyAccept");
    log("k* * * * $k");
    if (k == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 203, 223, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Açılıyor..",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
