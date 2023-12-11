import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../config/appConfig.dart';

class ThemeModel {
  static final homeTapIconColor = Colors.grey[800];

  final lightMode = ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blue,
    primaryColor: Colors.black,
    accentColor: HexColor(AppConfig.splashTextColor),
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: Colors.grey[100],
    brightness: Brightness.light,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepPurpleAccent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        filled: true, //<-- SEE HERE
        fillColor: Color.fromARGB(255, 238, 238, 239), //<-- SEE HERE
        labelStyle: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.grey[900],
        ),
        bodyText1: TextStyle(
            fontWeight: FontWeight.w700,
            color: HexColor("#827F7F"),
            fontSize: 18),
      ),
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[900]),
      headline4: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppConfig.appColor,
      ),
    ),
  );

  final darkMode = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.white,
      accentColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Color(0xff303030),
      brightness: Brightness.dark,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.grey[800],
      secondaryHeaderColor: Colors.grey[400],
      shadowColor: Color(0xff282828),
      backgroundColor: Colors.grey[900],
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, //<-- SEE HERE
          fillColor: Color.fromARGB(255, 238, 238, 239), //<-- SEE HERE
          labelStyle: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headline5: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: HexColor(AppConfig.appBarTextColor)),
          headline3: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[900],
          ),
          bodyText1: TextStyle(
              fontWeight: FontWeight.w700,
              color: HexColor("#827F7F"),
              fontSize: 18),
        ),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        subtitle2: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
            fontWeight: FontWeight.w700,
            color: HexColor("#827F7F"),
            fontSize: 18),
        headline4: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.orange,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ));
}
