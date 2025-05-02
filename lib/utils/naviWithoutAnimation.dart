// File: naviWithoutAnimation.dart
// Description: Navigation utility functions for the Sapphire: Terminal Trading application.
// This file provides standardized navigation methods for consistent screen transitions.

import 'package:flutter/material.dart';

/// Navigates to a new screen without animation
/// Simpler alternative to standard Navigator with MaterialPageRoute
/// 
/// Parameters:
/// - context: The BuildContext for navigation
/// - widget: The destination widget/screen to navigate to
void naviWithoutAnimation(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}