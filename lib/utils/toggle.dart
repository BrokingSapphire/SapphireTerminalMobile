// File: toggle.dart
// Description: Custom animated toggle switch for the Sapphire: Terminal Trading application.
// This file provides a reusable toggle switch with smooth sliding animation and color transitions.

import 'package:flutter/material.dart';

/// CustomToggleSwitch - A custom animated toggle switch widget
/// Provides a smooth sliding animation for the thumb with color transitions
/// Used for boolean settings, preferences, and on/off toggles throughout the app
class CustomToggleSwitch extends StatefulWidget {
  final bool initialValue;         // Initial state of the toggle (on/off)
  final ValueChanged<bool> onChanged; // Callback when toggle state changes
Color selectedColor;
  CustomToggleSwitch({
    super.key,
    this.initialValue = false,     // Default to off state
    required this.onChanged,       // Required callback for state changes
    this.selectedColor=Colors.green,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

/// State class for the CustomToggleSwitch widget
/// Handles animation and state management for the toggle
class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  late bool isChecked;              // Current toggle state
  late AnimationController _controller; // Controls the animation timing
  late Animation<double> _thumbPosition; // Position animation for the thumb

  @override
  void initState() {
    super.initState();
    // Initialize toggle state from widget property
    isChecked = widget.initialValue;

    // Setup animation controller with 200ms duration
    _controller = AnimationController(
      vsync: this, // Vsync with this widget's ticker provider
      duration: const Duration(milliseconds: 200), // Quick, smooth animation
    );

    // Create animation for the thumb position (0.0 = left, 1.0 = right)
    _thumbPosition = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Initialize animation state based on initial toggle value
    if (isChecked) {
      _controller.value = 1.0; // Start in the end position if checked
    }
  }

  /// Toggle the switch state and trigger animation
  void toggleSwitch() {
    setState(() {
      isChecked = !isChecked; // Flip the toggle state

      // Run animation in appropriate direction
      isChecked ? _controller.forward() : _controller.reverse();

      // Notify parent widget through callback
      widget.onChanged(isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: toggleSwitch, // Handle tap to toggle state
      child: AnimatedBuilder(
        animation: _controller, // Rebuild on animation changes
        builder: (context, child) {
          return Container(
            width: 60,
            height: 34,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              // Change background color based on toggle state and theme
              color: isChecked
                  ? widget.selectedColor         // Green when checked
                  : isDark
                  ? const Color(0xFF2E2E2E) // Dark gray in dark mode
                  : const Color(0xFFD1D5DB), // Light gray in light mode
              borderRadius: BorderRadius.circular(34), // Pill shape
            ),
            child: Align(
              // Animate thumb position using linear interpolation
              alignment: Alignment.lerp(Alignment.centerLeft,
                  Alignment.centerRight, _thumbPosition.value)!,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFFC), // Thumb color
                  shape: BoxShape.circle, // Circular thumb
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up animation controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}