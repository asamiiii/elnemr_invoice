import 'package:elnemr_invoice/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData? theme = ThemeData(
  //! AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: nemrYellow,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color:blackColor,
      fontSize: 25 ,
    )
  ),
  //! Scaffold Theme
  scaffoldBackgroundColor:scaffoldColor,
  textTheme:  TextTheme(

    headline1: GoogleFonts.notoKufiArabic( 

      fontSize:20,
      fontWeight: FontWeight.bold,
      
    
    ),
    headline2: GoogleFonts.notoKufiArabic(
      fontSize: 12,
      fontWeight: FontWeight.bold
    ),
    headline3: GoogleFonts.notoKufiArabic(
      fontSize: 10,
      fontWeight: FontWeight.bold
    ),
  )
);