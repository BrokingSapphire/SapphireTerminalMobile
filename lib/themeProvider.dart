// File: themeProvider.dart
// Description: Theme management provider for the Sapphire Trading application.
// This file handles theme switching, system theme detection, and theme change notifications.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // For accessing platform brightness

/// ThemeProvider - Manages application theme state
/// Handles theme mode selection (light/dark/system) and responds to system theme changes
/// Implements ChangeNotifier for state management and WidgetsBindingObserver for system theme detection
class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system; // Default to using system theme

  /// Constructor - Sets up system theme change listener
  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this); // Register as an observer to detect system theme changes
  }

  /// Getter for current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Sets the application theme mode and notifies listeners
  /// Used when user manually changes theme preference
  /// 
  /// Parameters:
  /// - mode: The ThemeMode to apply (light, dark, or system)
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners(); // Notify widgets that theme has changed
  }

  /// Determines if dark mode is currently active
  /// Considers both manual selection and system theme when in system mode
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // When using system theme, check platform brightness
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    }
    // Otherwise use the manually selected theme
    return _themeMode == ThemeMode.dark;
  }

  /// Called when platform brightness changes (system theme toggle)
  /// Implements method from WidgetsBindingObserver
  @override
  void didChangePlatformBrightness() {
    if (_themeMode == ThemeMode.system) {
      notifyListeners(); // Rebuild UI when system theme changes (only if in system mode)
    }
  }

  /// Cleanup method to be called when provider is no longer needed
  /// Removes the observer to prevent memory leaks
  void disposeProvider() {
    WidgetsBinding.instance.removeObserver(this); // Unregister observer
  }
}