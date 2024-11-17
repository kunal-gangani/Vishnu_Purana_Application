import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool isDarkMode;

  ThemeController({required this.isDarkMode});

  ThemeData get theme {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
