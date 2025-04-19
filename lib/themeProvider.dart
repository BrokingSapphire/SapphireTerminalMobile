import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  @override
  void didChangePlatformBrightness() {
    if (_themeMode == ThemeMode.system) {
      notifyListeners(); // 👈 This is what makes your app rebuild when system theme changes
    }
  }

  void disposeProvider() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
