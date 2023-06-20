import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.accentColorLight,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.white)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.titleColor),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor),
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black),
          titleSmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.black)));
  static ThemeData darkTheme = ThemeData();
}
