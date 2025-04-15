import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  TextEditingController priceController =
      TextEditingController(text: "6643.80");

  final List<String> _options = ["Delivery", "Intraday", "MTF"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Delivery / Intraday / MTF Tabs
            AnimatedOptionToggle(
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
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff2f2f2f)),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  height: 50.h,
                  width: 185.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
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
                  child: AnimatedDualToggle(
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
                "Market",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 5.h),

            // Price Input
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 15.sp, color: Color(0xffc9cacc)),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "₹",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Color(0xff2f2f2f)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.white),
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
                  "Trigger Price",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Qty 1 per leg",
                  style: TextStyle(fontSize: 11.sp, color: Color(0xffc9cacc)),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "₹",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Color(0xff2f2f2f)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                ),
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
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Qty 1 per leg",
                  style: TextStyle(fontSize: 11.sp, color: Color(0xffc9cacc)),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "₹",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Color(0xff2f2f2f)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            SizedBox(height: 15.h),

            // Stoploss and GTT
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _stopLoss = !_stopLoss;
                    });
                  },
                  child: CustomCheckbox(
                    size: 20,
                    value: _stopLoss,
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(width: 10.w),
                Text("StopLoss"),
                SizedBox(width: 5.w),
                Icon(Icons.info_outline, size: 15, color: Color(0xffc9cacc)),
                SizedBox(width: 35.w),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _gtt = !_gtt;
                    });
                  },
                  child: CustomCheckbox(
                    size: 20,
                    value: _gtt,
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(width: 10.w),
                Text("GTT"),
                SizedBox(width: 5.w),
                Icon(Icons.info_outline, size: 15, color: Color(0xffc9cacc)),
              ],
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
                      style: TextStyle(fontSize: 15.sp),
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
                          }),
                      SizedBox(width: 14.w),
                      Text("Day", style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 14.w),
                      CustomRadioButton(
                          isSelected: _validityOptionIndex == 1,
                          onTap: () {
                            setState(() {
                              _validityOptionIndex = 1;
                            });
                          }),
                      SizedBox(width: 14.w),
                      Text("IOC", style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 14.w),
                      CustomRadioButton(
                          isSelected: _validityOptionIndex == 2,
                          onTap: () {
                            setState(() {
                              _validityOptionIndex = 2;
                            });
                          }),
                      SizedBox(width: 14.w),
                      Text("Minutes", style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Disclose Quantity",
                              style: TextStyle(fontSize: 15.sp)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 50.h,
                            width: 160.w,
                            child: TextField(
                              controller: TextEditingController(text: "0"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 17.sp, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.h),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade700),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: "Enter value",
                                hintStyle: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.grey.shade600),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Minutes", style: TextStyle(fontSize: 15.sp)),
                          SizedBox(height: 6.h),
                          Container(
                            height: 50.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                              color: Color(0xff2f2f2f),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            padding: EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Color(0xffc9cacc),
                              ),
                            ),
                          ),
                        ],
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
