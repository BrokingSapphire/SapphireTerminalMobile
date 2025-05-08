import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/screens/home/orders/gttOrder/gttScreenWrapper.dart';
import 'package:sapphire/utils/toggle.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedIndex = 0;
  bool isExpanded = false;
  bool isExpanded2 = false;
  bool isActiveTrades = true;
  bool isMarketSelected = true;
  bool isNSE = true;
  bool isChecked = false;
  bool isEnabled = false;
  String selectedOption = "Delivery";
  final List<String> _options = ["Delivery", "Intraday", "MTF"];

  Widget _toggleButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45.h,
          width: 165.w,
          decoration: BoxDecoration(
            color: isSelected
                ? Color(0xff3A3A3A)
                : Colors.transparent, // Active & Inactive colors
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color:
                  isSelected ? Colors.green : Color(0xffC9CACC), // Text color
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionButton(String option, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45.h,
          width: 105.w,
          decoration: BoxDecoration(
            color: isSelected
                ? Color(0xff3A3A3A)
                : Colors.transparent, // Active & Inactive colors
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Text(
            option,
            style: TextStyle(
              color:
                  isSelected ? Colors.green : Color(0xffC9CACC), // Text color
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 28.w,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "RELIANCE",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "₹1,256.89 (+1.67%)",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff2F2F2F),
                  borderRadius: BorderRadius.circular(6.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNSE = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: 22.h,
                        width: 40.w,
                        child: Center(
                          child: Text(
                            'NSE',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color:
                                    isNSE ? Colors.white : Color(0xffC9CACC)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color:
                                isNSE ? Color(0xff1db954) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r)),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNSE = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: 22.h,
                        width: 40.w,
                        child: Center(
                          child: Text(
                            'BSE',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color:
                                    !isNSE ? Colors.white : Color(0xffC9CACC)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color:
                                !isNSE ? Color(0xff1db954) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Color(0xff2f2f2f),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  // Tab Bar
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff121413), // Background color
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.all(5.w),
                    child: Row(
                      children: _options.map((option) {
                        bool isSelected = option == selectedOption;
                        return _optionButton(
                          option,
                          isSelected,
                          () {
                            setState(() {
                              selectedOption = option;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 185.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No. of Share",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontFamily: "SFPro",
                                    fontSize: 11.sp), // Default text style
                                children: [
                                  TextSpan(text: 'Max Qty '), // Normal text
                                  TextSpan(
                                    text: '9', // Number with green color
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),

                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff2f2f2f)),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          height: 50.h,
                          width: 185.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("1"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xff2f2f2f),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              // Market Button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMarketSelected = true;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: isMarketSelected
                                          ? Color(0xff1db954)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      "Market",
                                      style: TextStyle(
                                          color: isMarketSelected
                                              ? Colors.white
                                              : Color(0xffebeef5),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              // Limit Button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMarketSelected = false;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: !isMarketSelected
                                          ? Color(0xff1db954)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      "Limit",
                                      style: TextStyle(
                                          color: !isMarketSelected
                                              ? Colors.white
                                              : Color(0xffebeef5),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Limit Price",
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff2f2f2f)),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "₹",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 20.h,
                          width: 1.w,
                          color: Colors.grey.shade700,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "6,643.80",
                          style: TextStyle(fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff121413),
                        borderRadius: BorderRadius.circular(6.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 11.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Create GTT',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 15,
                                  )),
                              Spacer(),
                              CustomToggleSwitch(
                                initialValue: false,
                                onChanged: (value) {
                                  print('Toggle is now: $value');
                                },
                              )
                            ],
                          ),
                          Visibility(
                              visible: isExpanded,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    color: Color(0xff2f2f2f),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Text(
                                    "Target Trigger Price",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff2f2f2f)),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    height: 50.h,
                                    // width: 185.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₹6,643.80"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    "Limit Price",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff2f2f2f)),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    height: 50.h,
                                    // width: 185.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₹6,643.80"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'OCO Order',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 15,
                                  )),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isExpanded2 = !isExpanded2;
                                    });
                                  },
                                  icon: Icon(
                                    isExpanded2 ? Icons.remove : Icons.add,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Visibility(
                              visible: isExpanded2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Target Trigger Price",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff2f2f2f),
                                      ),
                                    ),
                                    height: 50.h,
                                    // width: 185.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₹6,643.80"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    "Limit Price",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff2f2f2f)),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    height: 50.h,
                                    width: 185.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₹6,643.80"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black, // Match your background
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Margin Required",
                      style:
                          TextStyle(fontSize: 11.sp, color: Color(0xffC9CACC)),
                    ),
                    Text(
                      "₹75.68",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Charges",
                      style:
                          TextStyle(fontSize: 11.sp, color: Color(0xffC9CACC)),
                    ),
                    Text(
                      "₹75.68",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Margin",
                      style:
                          TextStyle(fontSize: 11.sp, color: Color(0xffC9CACC)),
                    ),
                    Text(
                      "₹75.68",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Icon(Icons.refresh, color: Colors.green, size: 22),
              ],
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff1DB954),
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'CREATE GTT',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
