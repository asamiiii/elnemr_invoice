import 'package:elnemr_invoice/core/colors.dart';
import 'package:flutter/material.dart';

ThemeData? theme = ThemeData(
  //! AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: cyanColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color:blackColor,
      fontSize: 25 ,
    )
  ),
  //! Scaffold Theme
  scaffoldBackgroundColor:scaffoldColor,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize:20,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      
    ),
    headline2: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold
    ),
    headline3: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold
    ),
  )
);