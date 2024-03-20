import 'package:flutter/material.dart';

ThemeData lightTheme(){
  return ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(),
    scaffoldBackgroundColor: Colors.white,
    
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20
      ),
      titleMedium: TextStyle(
        fontSize: 15
      ),
      titleSmall: TextStyle(
        fontSize: 13
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        fontSize: 15
      ),
      bodyMedium: TextStyle(
        fontSize: 14
      ),
      labelLarge: TextStyle(
        fontSize: 20
      ),
      labelMedium: TextStyle(
        fontSize: 15
      ),
      labelSmall: TextStyle(
        fontSize: 13
      )
    )
  );
}