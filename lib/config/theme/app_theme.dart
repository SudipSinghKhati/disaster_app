import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme(bool isDark) {
    return ThemeData(
      colorScheme:
          isDark ? const ColorScheme.dark() : const ColorScheme.light(),

      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'BioRhyme',
      useMaterial3: true,

      //appbarTheme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.yellow, fontSize: 20),
      ),

      //elevatedButton theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 106, 24, 150),
            foregroundColor: Colors.white),
      ),

      //bottomNavigation theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      //TextTheme
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color.fromARGB(255, 255, 230, 0),
        ),
      ),

      //theme inputDecoration
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 230, 0),
            width: 3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 255, 230, 0),
          ),
        ),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 0, 130, 237),
        ),
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 0, 130, 237),
        ),
      ),
    );
  }
}
