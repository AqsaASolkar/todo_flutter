import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      primaryColor: lavender,
      scaffoldBackgroundColor: color121212,
      appBarTheme: const AppBarTheme(
        backgroundColor: color121212,
        elevation: 0,
      ),
      fontFamily: GoogleFonts.lato().fontFamily,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: color1D1D1D,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(4)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: color535353, width: 1),
            borderRadius: BorderRadius.circular(4)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: color535353, width: 1),
            borderRadius: BorderRadius.circular(4)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: color535353, width: 1),
            borderRadius: BorderRadius.circular(4)),
        hintStyle: const TextStyle(
            color: color535353, fontSize: 16, fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(lavender),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400))),
      ));
}
