import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeAndLocalProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.dark;
  String appLocal = "en";
  changeAppTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appTheme', newTheme.name);
  }

  changeAppLocal(String newLocal) async {
    if (appLocal == newLocal) return;
    appLocal = newLocal;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appLocal', newLocal);
  }

  bool isDark(BuildContext context) {
    switch (appTheme) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('appTheme') ?? 'system';
    switch (themeString) {
      case 'dark':
        appTheme = ThemeMode.dark;
        break;
      case 'light':
        appTheme = ThemeMode.light;
        break;
      default:
        appTheme = ThemeMode.system;
    }
    appLocal = prefs.getString('appLocal') ?? 'en';

    notifyListeners();
  }
}
