import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.red,
    primaryColor: Colors.grey[300],
    hintColor: Colors.grey[400],
    highlightColor: Colors.red,
    textTheme: const TextTheme(
      headline6:TextStyle(
          color: Colors.black, fontWeight: FontWeight.w400,fontSize: 18),
      headline3: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500),
      headline1: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(color: Colors.grey, fontSize: 13),

    ),
    iconTheme: const IconThemeData(color: Colors.black));
