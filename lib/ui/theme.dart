import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color teal = Colors.teal;
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class AppTheme {
  static TextStyle headline1 = const TextStyle(
    color: darkHeaderClr,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static TextStyle introText = const TextStyle(
    color: bluishClr,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle darkHeadline = const TextStyle(
    color: darkGreyClr,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle buttonText = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle labelText = const TextStyle(
    color: Color.fromARGB(137, 7, 7, 7),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle hintText = const TextStyle(
    color: Color(0xffababab),
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static TextStyle taskCardTitle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    // fontFamily: "EduNSWACTFoundation",
    fontWeight: FontWeight.w400,
  );
  static TextStyle darkcardText = const TextStyle(
    color: Color(0xff3e3e3e),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle lightcardText = const TextStyle(
    color: Color(0xffababab),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}

// TextTheme textsTheme = TextTheme(
//   caption: const TextStyle(
//     color: darkHeaderClr,
//     fontSize: 12,
//     fontWeight: FontWeight.bold,
//   ),
//   headline1: const TextStyle(
//     color: darkHeaderClr,
//     fontSize: 30,
//     fontWeight: FontWeight.bold,
//   ),
//   headline2: const TextStyle(
//     color: darkHeaderClr,
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//   ),
//   headline3: const TextStyle(
//     color: darkHeaderClr,
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//   ),
//   headline4: const TextStyle(
//     color: darkHeaderClr,
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   ),
//   titleLarge: const TextStyle(
//     color: Colors.white,
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   ),
//   titleMedium: const TextStyle(
//     color: Colors.white,
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//   ),
//   titleSmall: const TextStyle(
//     color: Colors.white,
//     fontSize: 14,
//     fontWeight: FontWeight.w600,
//   ),
//   bodyText1: const TextStyle(
//     color: Colors.white,
//     fontSize: 16,
//     fontWeight: FontWeight.w400,
//   ),
//   subtitle1: const TextStyle(
//     color: Colors.white,
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//   ),button:
// );
// const appBarTheme = AppBarTheme(
//   backgroundColor: Colors.transparent,
//   elevation: 0,
//   toolbarHeight: 60,
//   titleTextStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 26,
//     fontWeight: FontWeight.bold,
//   ),
// );
InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: darkHeaderClr),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder.copyWith(
      borderSide: const BorderSide(color: primaryClr),
    ),
    focusedBorder: outlineInputBorder.copyWith(
      borderSide: const BorderSide(color: primaryClr),
    ),
    border: outlineInputBorder,
  );
}

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: white,
      brightness: Brightness.light,
      fontFamily: "Montserrat",
      inputDecorationTheme: inputDecorationTheme(),
      appBarTheme: const AppBarTheme(
        color: white,
        elevation: 0,
      )

      // textTheme: textsTheme,
      );
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.light,
    inputDecorationTheme: inputDecorationTheme(),
    appBarTheme: const AppBarTheme(
      color: darkGreyClr,
      elevation: 0,
    ),
  );
}
