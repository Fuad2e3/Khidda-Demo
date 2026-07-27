import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isBangla => _locale.languageCode == 'bn';

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleLanguage() {
    _locale = _locale.languageCode == 'en' ? const Locale('bn') : const Locale('en');
    notifyListeners();
  }
}
