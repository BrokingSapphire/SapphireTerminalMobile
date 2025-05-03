import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/sellWrapper.dart';
import 'package:sapphire/utils/animatedToggles.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/toggle.dart';

class NormalSellScreen extends StatefulWidget {
  final String tabName;

  NormalSellScreen(this.tabName);

  @override
  State<NormalSellScreen> createState() => _NormalSellScreenState();
}

class _NormalSellScreenState extends State<NormalSellScreen> {
  bool _stopLoss = false;
  bool _gtt = false;

  bool isExpanded = false;
  bool isMarketSelected = true;
  int _selectedIndex = 0;
  TextEditingController stopLossController = TextEditingController(text: "-5");
  TextEditingController targetController = TextEditingController(text: "+5");
  bool stoplossToggle = false;
  bool targetToggle = false;
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

            // Stoploss and GTT
            Visibility(
              visible: _validityOptionIndex != 1 || !isExpanded,
              child: Row(
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
                        SizedBox(width: 0.w),
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
                      ],
                    ),
                  ),
                  SizedBox(width: 35.w),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _gtt = !_gtt;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.red,
                          side: WidgetStateBorderSide.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return const BorderSide(
                                  color:
                                      Colors.red); // Border color when selected
                            }
                            return const BorderSide(
                                color: Color(
                                    0xff2f2f2f)); // Border color when unselected
                          }),
                          checkColor: Colors.white,
                          value: _gtt,
                          onChanged: (value) {
                            setState(() {
                              _gtt = value!;
                            });
                          },
                        ),
                        Text(
                          "GTT",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        SizedBox(width: 5.w),
                        Icon(Icons.info_outline,
                            size: 15,
                            color: isDark ? Color(0xffc9cacc) : Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              crossFadeState:
                  (_stopLoss && (_validityOptionIndex != 1 || !isExpanded))
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

            // Stoploss and GTT

            SizedBox(height: 18.h),
            AnimatedCrossFade(
              crossFadeState:
                  _gtt ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
                          "Stoploss %",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: Color(0xff2f2f2f),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                readOnly: !stoplossToggle,
                                controller: stopLossController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: isDark
                                      ? stoplossToggle
                                          ? Colors.white
                                          : Colors.grey
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none, // No border
                                  enabledBorder: InputBorder
                                      .none, // No border when enabled
                                  focusedBorder: InputBorder
                                      .none, // No border when focused
                                  disabledBorder: InputBorder
                                      .none, // No border when disabled
                                  errorBorder: InputBorder
                                      .none, // No border when in error state
                                  focusedErrorBorder: InputBorder
                                      .none, // No border when focused with error
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // Constrain Row to minimum size
                                      children: [
                                        Text(
                                          "%",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
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
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 15.h),
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              )),
                              Transform.scale(
                                scale: 0.7,
                                child: CustomToggleSwitch(
                                  selectedColor: Colors.red,
                                  initialValue: stoplossToggle,
                                  onChanged: (value) {
                                    setState(() {
                                      stoplossToggle = value;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                          "Target %",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: Color(0xff2f2f2f),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                readOnly: !targetToggle,
                                controller: targetController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: isDark
                                      ? stoplossToggle
                                          ? Colors.white
                                          : Colors.grey
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none, // No border
                                  enabledBorder: InputBorder
                                      .none, // No border when enabled
                                  focusedBorder: InputBorder
                                      .none, // No border when focused
                                  disabledBorder: InputBorder
                                      .none, // No border when disabled
                                  errorBorder: InputBorder
                                      .none, // No border when in error state
                                  focusedErrorBorder: InputBorder
                                      .none, // No border when focused with error
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // Constrain Row to minimum size
                                      children: [
                                        Text(
                                          "%",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
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
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 15.h),
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              )),
                              Transform.scale(
                                scale: 0.7,
                                child: CustomToggleSwitch(
                                  selectedColor: Colors.red,
                                  initialValue: targetToggle,
                                  onChanged: (value) {
                                    setState(() {
                                      stoplossToggle = value;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                          }),
                      SizedBox(width: 14.w),
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
                      SizedBox(width: 14.w),
                      sellRadioButton(
                          isSelected: _validityOptionIndex == 1,
                          onTap: () {
                            setState(() {
                              _validityOptionIndex = 1;
                            });
                          }),
                      SizedBox(width: 14.w),
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
                      SizedBox(width: 14.w),
                      sellRadioButton(
                          isSelected: _validityOptionIndex == 2,
                          onTap: () {
                            setState(() {
                              _validityOptionIndex = 2;
                            });
                          }),
                      SizedBox(width: 14.w),
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
            ),
          ],
        ),
      ),
    );
  }
}
