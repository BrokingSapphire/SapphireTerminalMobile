import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/orderWindow/buyWindow/buyWrapper.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constWidgets.dart';

class Icebergbuyscreen extends StatefulWidget {
  final String tabName;

  Icebergbuyscreen(this.tabName);

  @override
  State<Icebergbuyscreen> createState() => _IcebergbuyscreenState();
}

class _IcebergbuyscreenState extends State<Icebergbuyscreen> {
  bool _stopLoss = false;
  bool _gtt = false;

  bool isExpanded = false;
  bool isMarketSelected = true;
  int _selectedIndex = 0;
  int _validityOptionIndex = 0; // 0: Day, 1: IOC, 2: Minutes
  int quantity = 1;
  String? _selectedMinutes = '1 minute'; // Default value for dropdown

  // Map numbers to words for dropdown
  final List<String> _minutesOptions = [
    '1 minute',
    '2 minutes',
    '3 minutes',
    '5 minutes',
    '10 minutes',
    '15 minutes',
    '30 minutes',
    '45 minutes',
    '60 minutes',
    '90 minutes',
    '120 minutes',
  ];

  TextEditingController priceController =
      TextEditingController(text: "6643.80");

  final List<String> _options = ["Delivery", "Intraday", "MTF"];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Delivery / Intraday / MTF Tabs
            buyAnimatedToggle(
              options: _options,
              selectedIndex: _selectedIndex,
              onToggle: (index) {
                if (index == 2) {
                  constWidgets.snackbar("MTF is not available for Cover Order",
                      Colors.red, context);
                } else if (index == 0) {
                  constWidgets.snackbar(
                      "Delivery is not available for Cover Order",
                      Colors.red,
                      context);
                }
              },
            ),
            SizedBox(height: 20.h),

            // Quantity
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Quantity",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : Colors.black),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? Color(0xff2f2f2f)
                          : Color(0xff2f2f2f).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  height: 50.h,
                  width: 190.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 80.w,
                        // Fixed width for TextField to fit within container
                        child: TextField(
                          controller: TextEditingController(
                              text: quantity.toString())
                            ..selection = TextSelection.fromPosition(
                              TextPosition(offset: quantity.toString().length),
                            ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder
                                .none, // Explicitly remove enabled border
                            focusedBorder: InputBorder
                                .none, // Explicitly remove focused border
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Restrict to digits
                          ],
                          onChanged: (value) {
                            setState(() {
                              // Parse input or default to 1 if empty/invalid
                              quantity = int.tryParse(value) ?? 1;
                              if (quantity < 1)
                                quantity = 1; // Enforce minimum of 1
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),

                // Market / Limit Toggle
                Expanded(
                  child: buyScreenToggle(
                    isFirstOptionSelected: isMarketSelected,
                    onToggle: (value) {
                      setState(() {
                        isMarketSelected = value;
                      });
                    },
                    firstOption: "Market",
                    secondOption: "Limit",
                  ),
                )
              ],
            ),

            SizedBox(height: 16.h),

            // Market Label
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Price",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : Colors.black),
              ),
            ),
            SizedBox(height: 5.h),

            TextField(
              readOnly: isMarketSelected,
              controller: priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                fontSize: 15.sp,
                color: isMarketSelected
                    ? Colors.grey.shade600 // Grey content color when readOnly
                    : (isDark
                        ? Colors.white
                        : Colors.black), // White/black when not readOnly
              ),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₹",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 40.h,
                        width: 2.w,
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xff2f2f2f) : Color(0xff2f2f2f),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 15.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    color: isDark
                        ? Color(0xff2f2f2f)
                        : Color(0xff2f2f2f).withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: isMarketSelected
                      ? BorderSide.none // No focused border when readOnly
                      : BorderSide(
                          color: isDark ? Colors.white : Colors.white,
                          width: 2.0,
                        ), // White focused border when not readOnly
                ),
                hintText: "Enter Price",
                hintStyle:
                    TextStyle(color: Colors.grey.shade600, fontSize: 15.sp),
              ),
            ),

            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Number of legs",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white : Colors.black),
                ),
                Text(
                  "1 Qty per Leg",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? Color(0xffc9cacc) : Colors.black),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                  fontSize: 16.sp, color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                      color: isDark
                          ? Color(0xff2f2f2f)
                          : Color(0xff2f2f2f).withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide:
                      BorderSide(color: isDark ? Colors.white : Colors.black),
                ),
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            SizedBox(height: 15.h),

            // Stoploss and GTT
            AnimatedCrossFade(
              crossFadeState: ((_selectedIndex != 1) &&
                      (_validityOptionIndex != 1 || !isExpanded))
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
              firstChild: SizedBox.shrink(),
              secondChild: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _stopLoss = !_stopLoss;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                            value: _stopLoss,
                            onChanged: (value) {
                              setState(() {
                                _stopLoss = value!;
                              });
                            }),
                        Text(
                          "Stoploss",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        SizedBox(width: 5.w),
                        Icon(Icons.info_outline,
                            size: 15,
                            color: isDark ? Color(0xffc9cacc) : Colors.black),
                        SizedBox(width: 35.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),
            AnimatedCrossFade(
              crossFadeState: _stopLoss
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
              firstChild: SizedBox.shrink(),
              secondChild: Row(
                children: [
                  Flexible(
                    flex: 1, // Equal width for both columns
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trigger Price",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    height: 40.h,
                                    width: 2.w,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Color(0xff2f2f2f)
                                          : Color(0xff2f2f2f),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xff2f2f2f)
                                    : Color(0xff2f2f2f).withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w), // Add spacing between columns
                  Flexible(
                    flex: 1, // Equal width for both columns
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Limit",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    height: 40.h,
                                    width: 2.w,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Color(0xff2f2f2f)
                                          : Color(0xff2f2f2f),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xff2f2f2f)
                                    : Color(0xff2f2f2f).withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Expandable Section Header
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Show Validity/Disclose Qty",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    Icon(isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            // Expandable Content
            AnimatedCrossFade(
              firstChild: SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      CustomRadioButton(
                        isSelected: _validityOptionIndex == 0,
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 0;
                          });
                        },
                      ),
                      SizedBox(width: 6.w),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 0;
                          });
                        },
                        child: Text(
                          "Day",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      CustomRadioButton(
                        isSelected: _validityOptionIndex == 1,
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 1;
                          });
                        },
                      ),
                      SizedBox(width: 6.w),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 1;
                          });
                        },
                        child: Text(
                          "IOC",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      CustomRadioButton(
                        isSelected: _validityOptionIndex == 2,
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 2;
                          });
                        },
                      ),
                      SizedBox(width: 6.w),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _validityOptionIndex = 2;
                          });
                        },
                        child: Text(
                          "Minutes",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Disclose Quantity",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              height: 50.h,
                              child: TextField(
                                readOnly: _validityOptionIndex == 1,
                                // Read-only for IOC
                                controller: TextEditingController(text: "0"),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: _validityOptionIndex == 1
                                      ? Colors.grey.shade600
                                      : (isDark ? Colors.white : Colors.black),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 15.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: BorderSide(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  hintText: "Enter value",
                                  hintStyle: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Minutes",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              height: 50.h,
                              child: DropdownButtonFormField<String>(
                                value: _selectedMinutes,
                                onChanged: _validityOptionIndex == 2
                                    ? (String? newValue) {
                                        setState(() {
                                          _selectedMinutes = newValue;
                                        });
                                      }
                                    : null,
                                // Disable for Day and IOC
                                items: _minutesOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: _validityOptionIndex == 0 ||
                                                _validityOptionIndex == 1
                                            ? Colors.grey.shade600
                                            : (isDark
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 15.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: BorderSide(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  hintText: "Select minutes",
                                  hintStyle: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: _validityOptionIndex == 0 ||
                                          _validityOptionIndex == 1
                                      ? Colors.grey.shade600
                                      : (isDark ? Colors.white : Colors.black),
                                ),
                                dropdownColor: isDark
                                    ? Colors.grey.shade800
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 200),
            )
          ],
        ),
      ),
    );
  }
}

class buyScreenToggle extends StatelessWidget {
  // Required parameters
  final bool isFirstOptionSelected;
  final Function(bool) onToggle;
  final String firstOption;
  final String secondOption;

  // Optional customization parameters
  final Color? backgroundColor; // Background color of the toggle
  final Color? selectedColor; // Color of the selected tab
  final Color? textColor; // Text color for selected option
  final Color? unselectedTextColor; // Text color for unselected option
  final double height; // Height of the toggle
  final double borderRadius; // Border radius of the toggle corners

  buyScreenToggle({
    Key? key,
    required this.isFirstOptionSelected,
    required this.onToggle,
    required this.firstOption,
    required this.secondOption,
    this.backgroundColor, // Remove default values to allow theme-based colors
    this.selectedColor,
    this.textColor,
    this.unselectedTextColor,
    this.height = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if we're in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Define theme-specific colors
    final Color actualBackgroundColor = backgroundColor ??
        (isDark ? const Color(0xff2f2f2f) : const Color(0xfff5f5f5));

    final Color actualSelectedColor = selectedColor ??
        (isDark ? const Color(0xff1db954) : const Color(0xff1db954));

    final Color actualTextColor = textColor ?? Colors.white;

    final Color actualUnselectedTextColor = unselectedTextColor ??
        (isDark ? const Color(0xffebeef5) : const Color(0xff6B7280));

    return Container(
      height: height.h,
      // Apply theme-specific background color
      decoration: BoxDecoration(
        color: actualBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment
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
                  // Apply theme-specific selected color
                  decoration: BoxDecoration(
                    color: actualSelectedColor,
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          firstOption,
                          style: TextStyle(
                            // Apply appropriate text color based on selection state
                            color: isFirstOptionSelected
                                ? actualTextColor
                                : actualUnselectedTextColor,
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          secondOption,
                          style: TextStyle(
                            // Use consistent text color logic for second option
                            color: !isFirstOptionSelected
                                ? actualTextColor
                                : actualUnselectedTextColor,
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

class buyAnimatedToggle extends StatefulWidget {
  // Required parameters
  final List<String> options;
  final int selectedIndex;
  final Function(int) onToggle;

  // Optional customization parameters that can be theme-aware
  final Color? backgroundColor; // Background color of the entire toggle
  final Color? selectedBackgroundColor; // Background color of the selected tab
  final Color? selectedTextColor; // Text color for the selected option
  final Color? unselectedTextColor; // Text color for unselected options
  final double height; // Height of the toggle
  final double borderRadius; // Border radius of the toggle corners

  const buyAnimatedToggle({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onToggle,
    this.backgroundColor, // Remove default values to be theme-aware
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.height = 40,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  State<buyAnimatedToggle> createState() => _buyAnimatedToggleState();
}

class _buyAnimatedToggleState extends State<buyAnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    // Check if we're in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Define theme-specific colors
    final Color actualBackgroundColor = widget.backgroundColor ??
        (isDark ? const Color(0xff121413) : const Color(0xffF0F0F0));

    final Color actualSelectedBackgroundColor =
        widget.selectedBackgroundColor ??
            (isDark ? const Color(0xff2f2f2f) : Colors.white);

    final Color actualSelectedTextColor = widget.selectedTextColor ??
        (isDark ? const Color(0xff1db954) : const Color(0xff1db954));

    final Color actualUnselectedTextColor = widget.unselectedTextColor ??
        (isDark ? Colors.grey : const Color(0xff6B7280));

    return Container(
      height: widget.height.h,
      width: double.infinity,
      // Apply theme-specific background color
      decoration: BoxDecoration(
        color: actualBackgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment based on number of options
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
                  // Apply theme-specific selected background color
                  decoration: BoxDecoration(
                    color: actualSelectedBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius - 4),
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
                            // Apply appropriate text color based on selection state
                            color: widget.selectedIndex == index
                                ? actualSelectedTextColor
                                : actualUnselectedTextColor,
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
