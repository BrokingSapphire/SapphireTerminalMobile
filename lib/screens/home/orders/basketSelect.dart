import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constWidgets.dart';

class basketSelectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stocks = [
    {
      "trigger": "56.80",
      "ltp": "₹1,226.90",
      "type": "BUY",
      "price": "₹1,580.60",
      "quantity": "200",
      "tags": ["FO", "DELIVERY", "SL-M"],
    },
    {
      "trigger": "56.80",
      "ltp": "₹1,226.90",
      "type": "BUY",
      "price": "₹1,580.60",
      "quantity": "200",
      "tags": ["FO", "DELIVERY", "SL-M"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 26,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Stock 1",
                      style: TextStyle(
                        fontSize: 15.sp,
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min, // ✅ Prevents extra spacing
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 14,
                        color: Colors.green,
                      ),
                      SizedBox(width: 6.w), // ✅ Adds EXACTLY 6px spacing
                      Text(
                        "Edit",
                        style: TextStyle(fontSize: 12.sp, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text("Created on 22 Feb 2025",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: Color(0xffEBEEF5))),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Text("04/50 Stocks",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: Color(0xffEBEEF5))),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Divider(color: Color(0xff2f2f2f)),
              SizedBox(height: 10.h),

              // Search Bar
              constWidgets.searchField(
                  context, "Search Everything...", "orders"),
              SizedBox(height: 11.h),

              Divider(color: Color(0xff2f2f2f)),

              // Stock List
              Expanded(
                child: ListView.builder(
                  itemCount: stocks.length,
                  itemBuilder: (context, index) {
                    final stock = stocks[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 11.h,
                              bottom:
                                  11.h), // Add padding inside instead of margin
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Trigger ${stock['trigger']}  LTP ${stock['ltp']}",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Color(0xffC9CACC))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(0xff143520),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      "BUY",
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("RELIANCE FEB 1200 CE",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xffEBEEF5))),
                                  Text(stock['price'],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xffEBEEF5))),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: stock['tags'].map<Widget>((tag) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 4.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: Color(0xff4444444D),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Text(tag,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Color(0xffC9CACC))),
                                      );
                                    }).toList(),
                                  ),
                                  Text("Qty ${stock['quantity']}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xffC9CACC))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (index <
                            stocks.length -
                                0) // Show divider only between items
                          Divider(color: Color(0xff2f2f2f)),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Final Margin",
                            style: TextStyle(
                                fontSize: 11.sp, color: Color(0xffC9CACC))),
                        Text("₹75.68",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Available Margin",
                            style: TextStyle(
                                fontSize: 11.sp, color: Color(0xffC9CACC))),
                        Text("₹7,895.68",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
