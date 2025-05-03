import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/sellWrapper.dart';
import 'package:sapphire/utils/animatedToggles.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constWidgets.dart';

class IcebergSellScreen extends StatefulWidget {
  final String tabName;
  IcebergSellScreen(this.tabName);

  @override
  State<IcebergSellScreen> createState() => _IcebergSellScreenState();
}

class _IcebergSellScreenState extends State<IcebergSellScreen> {
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
            sellAnimatedToggle(
              options: _options,
              selectedIndex: _selectedIndex,
              onToggle: (index) {
                setState(() {
                  _selectedIndex = index;
                });
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
                        width: 80
                            .w, // Fixed width for TextField to fit within container
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
                  child: sellScreenToggle(
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

            // Price Input
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

            SizedBox(height: 16.h),

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
                  "Qty 1 per leg",
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
                    "₹",
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
                          activeColor: Colors.red,
                          side: MaterialStateBorderSide.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return const BorderSide(
                                  color:
                                      Colors.red); // Border color when selected
                            }
                            return const BorderSide(
                                color: Color(
                                    0xff2f2f2f)); // Border color when unselected
                          }),
                          checkColor: Colors.white,
                          value: _stopLoss,
                          onChanged: (value) {
                            setState(() {
                              _stopLoss = value!;
                            });
                          },
                        ),
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

            SizedBox(height: 18.h),

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
                      sellRadioButton(
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
                      sellRadioButton(
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
                      sellRadioButton(
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
                                readOnly: _validityOptionIndex ==
                                    1, // Read-only for IOC
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
                                    : null, // Disable for Day and IOC
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
