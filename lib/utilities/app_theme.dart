import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      canvasColor: AppColors.canvasColorLight,
      primaryColor: AppColors.primaryColorLight,
      scaffoldBackgroundColor: AppColors.accentColorLight,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColorLight,
          unselectedItemColor: AppColors.titleColor),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColorLight),
          titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          titleSmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.black)));
  static ThemeData darkTheme = ThemeData(
      canvasColor: AppColors.canvasColorDark,
      primaryColor: AppColors.primaryColorLight,
      scaffoldBackgroundColor: AppColors.accentColorDark,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColorDark,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColorLight,
          unselectedItemColor: AppColors.titleColor),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColorLight),
          titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColorLight),
          titleSmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white)));
}
