import 'package:flutter/material.dart';

class LiveFeedTheme {
  static Color get screensBackgroundColor => Colors.grey[100];

  static ThemeData get theme {
    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;
    final bodyText1 = textTheme.bodyText1.copyWith(
      decorationColor: Colors.transparent,
      fontFamily: 'Montserrat',
    );
    final bodyText2 = textTheme.bodyText2.copyWith(
      decorationColor: Colors.transparent,
      fontFamily: 'Montserrat',
    );
    final buttonText = textTheme.button.copyWith(
      decorationColor: Colors.transparent,
      fontFamily: 'Montserrat',
    );
    var appliedTextTheme = textTheme.apply(
      decorationColor: Colors.transparent,
      fontFamily: 'Montserrat',
    );
    final headline1 = appliedTextTheme.headline1.copyWith(
      decorationColor: Colors.transparent,
      fontFamily: 'BebasNeue',
      fontSize: 46,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return ThemeData.light().copyWith(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      buttonColor: Color.fromRGBO(255, 0, 0, 1),
      disabledColor: Colors.grey,
      accentColor: Color.fromRGBO(255, 0, 0, 1),
      highlightColor: Color.fromRGBO(170, 59, 241, 1),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[200],
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        hintStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: 1.55,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800]),
        ),
      ),
      textTheme: appliedTextTheme.copyWith(
        headline1: headline1,
        // bodyText1: bodyText1,
        // bodyText2: bodyText2,
        // button: buttonText,
      ),
    );
  }
}
