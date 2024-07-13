import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

abstract class Styles {
  static TextStyle style25 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      height: 0,
    ),
  );

  static TextStyle style18 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: myPurple,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 0,
    ),
  );

  static TextStyle style18Bold = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: myGrey,
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      height: 0,
    ),
  );

  static TextStyle style16Bold = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      height: 0,
    ),
  );

  static TextStyle style16 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      height: 0,
    ),
  );

  static TextStyle style20 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      height: 0,
    ),
  );

  static TextStyle style24 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      height: 0,
    ),
  );

  static TextStyle style22 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      height: 0,
    ),
  );

  static TextStyle style42 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: myPurple,
      fontSize: 42,
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      height: 0,
    ),
  );

  static TextStyle style36 = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: myPurple,
      fontSize: 36,
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      height: 0,
    ),
  );

  static TextStyle style18withObacity = GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.black.withOpacity(0.699999988079071),
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      height: 0,
    ),
  );
}
