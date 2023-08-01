// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary=Color.fromARGB(255, 219, 255, 238);
  static const colorSeed = Colors.green;
  static const scaffoldBackgroundColor = primary;//.fromARGB(255, 205, 247, 197)
  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.mulish()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.mulish()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.mulish()
        .copyWith( fontSize: 20 )
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.mulish()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.mulish()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),
    )
  );
}