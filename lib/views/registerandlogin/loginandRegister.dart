import 'package:avatar_glow/avatar_glow.dart';
import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/provider/articleCtx.dart';
import 'package:mindflow/services/auth.dart';
import 'package:mindflow/views/registerandlogin/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

import '../../privacyPolicy.dart';
import '../../provider/authCtx.dart';
import '../../widgets/animatedSplash.dart';
import 'login.dart';

bool privacyPolicyAccepted = false;

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }
// Başlangıçta gizlilik sözleşmesi kabul edilmemiş olarak ayarlanır.

// Gizlilik Sözleşmesi'nin kabul edilip edilmediğini kontrol eden metot
  void onPrivacyPolicyAccepted(bool value) {
    setState(() {
      privacyPolicyAccepted = value;
    });
  }

  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    //_authServices.signOut();
    final _authProvider = Provider.of<AuthCtx>(context, listen: true);
    final _articleCtx = Provider.of<ArticleCtx>(context, listen: true);

    final color = Colors.black;
    _scale = 1 - _controller.value;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return null!;
        },
        child: Scaffold(
            backgroundColor: Color.fromRGBO(203, 203, 223, 1),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    AvatarGlow(
                      endRadius: 90,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.white24,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/Mindflow.png"))),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Merhaba",
                        style: GoogleFonts.signika(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      delay: delayedAmount + 1000,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "MindFlow'a ",
                        style: GoogleFonts.courgette(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                        //greatVibes,courgette
                      ),
                      delay: delayedAmount + 2000,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Hoşgeldiniz",
                        style: GoogleFonts.signika(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      delay: delayedAmount + 2000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "İstediğiniz Konuda",
                        style: GoogleFonts.signika(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Makale Paylaşabilirsiniz",
                        style: GoogleFonts.signika(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    SignInButton(
                      buttonType: ButtonType.google,
                      btnText: "Google ile giriş yap",
                      buttonSize: ButtonSize.large,
                      onPressed: () async {
                        AuthServices authServices = AuthServices();
                        await authServices.signInWithGoogle(
                            context: context, isPrivacyPolicyAccepted: false);
                        ;
                      },
                    ),
                    /*    DelayedAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Register();
                            },
                          ));
                        },
                        child: _animatedButtonUIRegister,
                      ),
                      delay: delayedAmount + 4000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Hesabın var mı ?",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      delay: delayedAmount + 5000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),*/
                    SizedBox(
                      height: 50,
                    ),
                    Visibility(
                      visible: _articleCtx.isTestOpen!,
                      child: GestureDetector(
                        onTap: () {
                          _onTapDown(_authProvider);
                        },
                        child: _animatedButtonUI,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
        color: Color.fromARGB(255, 49, 51, 85),
        ),
        child: Center(
          child: Text(
            'Test Girişi',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
  Widget get _animatedButtonUIRegister => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xFF8185E2),
        ),
        child: Center(
          child: Text(
            'Kayıt Ol',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black //Color(0xFF8185E2),
                ),
          ),
        ),
      );
  void _onTapDown(_authProvider) {
    _authProvider.login(
        context: context, email: "test@gmail.com", password: "Mevlana10");
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
