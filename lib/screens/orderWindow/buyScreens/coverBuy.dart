import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/orderWindow/buyScreens/buyWrapper.dart';
import 'package:sapphire/utils/animatedToggles.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constWidgets.dart';

class MTFBuyScreen extends StatefulWidget {
  final String tabName;

  MTFBuyScreen(this.tabName);

  @override
  State<MTFBuyScreen> createState() => _MTFBuyScreenState();
}

class _MTFBuyScreenState extends State<MTFBuyScreen> {
  bool _stopLoss = false;
  bool _gtt = false;

  bool isExpanded = false;
  bool isMarketSelected = true;
  int _selectedIndex = 1;
  int quantity = 1;

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

            // Trigger Price Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stoploss Trigger",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                fontSize: 15.sp,
                color: isDark
                    ? Colors.white
                    : Colors.black, // Grey content color when readOnly
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

            // Expandable Section Header
          ],
        ),
      ),
    );
  }
}
