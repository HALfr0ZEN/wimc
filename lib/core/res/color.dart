import 'package:flutter/material.dart';

class AppColors {
  static bool isDarkMode = false;

  static Color get primaryColor => const Color(0xffd61557);
  static Color get secondaryColor => Color.fromRGBO(102, 186, 168, 1);
  static Color get primaryAccentColor => const Color(0xfff44336);
  static Color get primaryHeaderColor =>
      const Color.fromARGB(255, 77, 128, 117);
  static MaterialColor get primarySwatch => Colors.grey;
  static Color get textColor => const Color.fromARGB(255, 244, 232, 239);
  static Color get backgroundColor =>
      isDarkMode ? Colors.black : const Color.fromARGB(255, 244, 232, 239);

  static ThemeData get getTheme => ThemeData(
        primaryColor: Colors.white,
        primarySwatch: primarySwatch,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(
            color: Colors.grey[500],
          ),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.secondaryColor)),
        ),
        buttonTheme: ButtonThemeData(buttonColor: secondaryColor),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primaryHeaderColor),
          labelStyle: TextStyle(color: primaryHeaderColor.withOpacity(.5)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryHeaderColor, width: 20),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor.withOpacity(.5))),
          contentPadding: const EdgeInsetsDirectional.all(15),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 36,
          ),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
        scaffoldBackgroundColor: backgroundColor,
      );
}
