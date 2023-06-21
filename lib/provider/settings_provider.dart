import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLocal = "en";
  ThemeMode currentTheme = ThemeMode.light;

  changeCurrentLocal({required String languageSelected}) {
    currentLocal = languageSelected;
    notifyListeners();
  }

  changeCurrentTheme({required ThemeMode newTheme}) {
    currentTheme = newTheme;
    notifyListeners();
  }
}
