import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xff15141f),
    elevation: 0.00
  ),
    useMaterial3: false,
    scaffoldBackgroundColor: const Color(0xff15141f),
    primarySwatch: Colors.red,
    primaryColor: const Color(0xff1e1c2c),
    hintColor: Colors.grey[400],
    highlightColor: Colors.white.withOpacity(0.8),
    textTheme: const TextTheme(
      headline6:TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400,fontSize: 18),
      headline3: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500),
      headline1: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(color: Colors.grey, fontSize: 13),

    ),
    iconTheme: const IconThemeData(color: Colors.white));
