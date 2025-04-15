import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom animated toggle widget for multiple options with sliding animation
class AnimatedOptionToggle extends StatefulWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onToggle;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double height;
  final double borderRadius;

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
          final segmentWidth = constraints.maxWidth / widget.options.length;
          
          return Stack(
            children: [
              // Animated selection indicator
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: widget.selectedIndex * segmentWidth + 4,
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
              
              // Option texts
              Row(
                children: List.generate(widget.options.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onToggle(index),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.options[index],
                          style: TextStyle(
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

/// A custom animated toggle widget for two options (like Market/Limit) with sliding animation
class AnimatedDualToggle extends StatelessWidget {
  final bool isFirstOptionSelected;
  final Function(bool) onToggle;
  final String firstOption;
  final String secondOption;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color unselectedTextColor;
  final double height;
  final double borderRadius;

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
          final segmentWidth = constraints.maxWidth / 2;
          
          return Stack(
            children: [
              // Animated selection indicator
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isFirstOptionSelected ? 0 : segmentWidth,
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
              
              // Option texts
              Row(
                children: [
                  // First option (e.g., Market)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          firstOption,
                          style: TextStyle(
                            color: isFirstOptionSelected ? textColor : unselectedTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Second option (e.g., Limit)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          secondOption,
                          style: TextStyle(
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
