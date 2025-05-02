// File: animatedToggles.dart
// Description: Custom animated toggle widgets for the Sapphire: Terminal Trading application.
// This file provides reusable toggle components with smooth animations for selection UI.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// AnimatedOptionToggle - A custom animated toggle widget for multiple options
/// Provides a smooth sliding animation when switching between options
/// Used for tab-like navigation or option selection with more than two choices
class AnimatedOptionToggle extends StatefulWidget {
  final List<String> options;            // List of text options to display
  final int selectedIndex;               // Currently selected option index
  final Function(int) onToggle;          // Callback when option is selected
  final Color backgroundColor;           // Background color of the entire toggle
  final Color selectedBackgroundColor;   // Background color of the selected option indicator
  final Color selectedTextColor;         // Text color for the selected option
  final Color unselectedTextColor;       // Text color for unselected options
  final double height;                   // Height of the toggle widget
  final double borderRadius;             // Corner radius of the toggle container

  const AnimatedOptionToggle({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onToggle,
    this.backgroundColor = const Color(0xff121413),
    this.selectedBackgroundColor = const Color(0xff2f2f2f),
    this.selectedTextColor = Colors.green,
    this.unselectedTextColor = Colors.grey,
    this.height = 40,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  State<AnimatedOptionToggle> createState() => _AnimatedOptionToggleState();
}

/// State class for the AnimatedOptionToggle widget
/// Handles the layout and animation of the toggle options
class _AnimatedOptionToggleState extends State<AnimatedOptionToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment based on available space
          final segmentWidth = constraints.maxWidth / widget.options.length;

          return Stack(
            children: [
              // Animated selection indicator that slides between options
              AnimatedPositioned(
                duration: Duration(milliseconds: 300), // Animation duration
                curve: Curves.easeInOut,               // Smooth animation curve
                left: widget.selectedIndex * segmentWidth + 4, // Position based on selected index
                top: 4,
                child: Container(
                  height: widget.height.h - 8,
                  width: segmentWidth - 8,
                  decoration: BoxDecoration(
                    color: widget.selectedBackgroundColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius - 4),
                  ),
                ),
              ),

              // Option text labels row
              Row(
                children: List.generate(widget.options.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onToggle(index), // Call toggle callback with index
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.options[index],
                          style: TextStyle(
                            // Change text color based on selection state
                            color: widget.selectedIndex == index
                                ? widget.selectedTextColor
                                : widget.unselectedTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// AnimatedDualToggle - A custom animated toggle widget specifically for two options
/// Used for binary choices like Market/Limit order types, Buy/Sell direction, etc.
/// Provides a smooth sliding animation with color change when switching options
class AnimatedDualToggle extends StatelessWidget {
  final bool isFirstOptionSelected;     // Whether first option is currently selected
  final Function(bool) onToggle;        // Callback with boolean indicating first option selection
  final String firstOption;             // Text for first option (left side)
  final String secondOption;            // Text for second option (right side)
  final Color backgroundColor;          // Background color of entire toggle
  final Color selectedColor;            // Background color of selected option indicator
  final Color textColor;                // Text color for selected option
  final Color unselectedTextColor;      // Text color for unselected option
  final double height;                  // Height of the toggle widget
  final double borderRadius;            // Corner radius of the toggle container

  const AnimatedDualToggle({
    Key? key,
    required this.isFirstOptionSelected,
    required this.onToggle,
    required this.firstOption,
    required this.secondOption,
    this.backgroundColor = const Color(0xff2f2f2f),
    this.selectedColor = const Color(0xff1db954),
    this.textColor = Colors.white,
    this.unselectedTextColor = const Color(0xffebeef5),
    this.height = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment (always two options)
          final segmentWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              // Animated selection indicator that slides between options
              AnimatedPositioned(
                duration: Duration(milliseconds: 300), // Animation duration
                curve: Curves.easeInOut,               // Smooth animation curve
                left: isFirstOptionSelected ? 0 : segmentWidth, // Position based on selection
                top: 0,
                child: Container(
                  height: height.h,
                  width: segmentWidth,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                ),
              ),

              // Option texts row
              Row(
                children: [
                  // First option (left side)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(true), // Select first option
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          firstOption,
                          style: TextStyle(
                            // Change text color based on selection state
                            color: isFirstOptionSelected ? textColor : unselectedTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Second option (right side)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(false), // Select second option
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          secondOption,
                          style: TextStyle(
                            // Change text color based on selection state
                            color: !isFirstOptionSelected ? textColor : unselectedTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}