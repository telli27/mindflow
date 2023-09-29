import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/views/registerandlogin/register.dart';
import 'package:mindflow/widgets/InkWellButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/authCtx.dart';
import '../../services/auth.dart';
import '../../widgets/TextInputWidget.dart';
import '../../widgets/TextPasswordInputWidget.dart';
import '../../widgets/showMesages.dart';
import '../ArticleStart.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color navigationBarColor = AppConfig.appColor;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formCtx = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final _authProvider = Provider.of<AuthCtx>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: AppConfig.appColor,
          body: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    backgroundImage: AssetImage(
                      "assets/resim2.jpg",
                    ),
                    radius: 75.0,
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Form(
                            key: _formCtx,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                TextInputWidget(
                                  readOnly: false,
                                  controller: emailController,
                                  hintText: "Email",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Boş Olamaz";
                                    } else if (!value.contains("@") ||
                                        !value.contains('.')) {
                                      return "Lütfen geçerli bir e-posta giriniz";
                                    }
                                    return null;
                                  },
                                ),
                                TextPasswordInputWidget(
                                  controller: passwordController,
                                  hintText: "Şifre",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Boş Olamaz';
                                    } else if (value.length < 6) {
                                      return 'Şifre En az 6 Karakter Uzunkluğunda Olmalı';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWellButton(
                                    buttonTitle: 'Giriş Yap',
                                    onTap: () async {
                                      if (_formCtx.currentState?.validate() ==
                                          true) {
                                        _authProvider.login(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    indicatorWidget: Container(
                                      width: 20,
                                      height: 20,
                                      child:
                                          _authProvider.registerLoading == true
                                              ? CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Hesabın yok mu? ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return Register();
                                            },
                                          ));
                                        },
                                        child: Text("Kayıt Ol",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
           
            ],
          ),
        ));
  }
}
