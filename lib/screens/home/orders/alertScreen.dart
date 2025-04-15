import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constWidgets.dart';

class alertScreen extends StatefulWidget {
  @override
  _alertScreenState createState() => _alertScreenState();
}

class _alertScreenState extends State<alertScreen> {
  String selectedPriceType = "Last price";
  String selectedCondition = "Greater than or equal to (>=)";
  final TextEditingController priceController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 38.w,
            title: Text("Create New Alert",
                style: TextStyle(color: Colors.white, fontSize: 15.sp)),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Divider(
                color: Colors.grey.shade800,
                thickness: 1.h,
                height: 1.h,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.h,
                ),
                Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF121413),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Stock',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 10.w),
                      prefixIcon:
                          Icon(Icons.search, color: Colors.grey, size: 22.sp),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 40.w, minHeight: 20.h),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text("NIFTY 50",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffC9CACC))),
                SizedBox(height: 13.h),
                Card(
                  elevation: 3,
                  color: Color(0xff121413),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create alert",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 22.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("If"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  height: 50.h,
                                  width: 150.w,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedPriceType,
                                    items: [
                                      "Last price",
                                      "Open price",
                                      "Close price"
                                    ]
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPriceType = value!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("of"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  height: 50.h,
                                  width: 150.w,
                                  child: TextField(
                                    readOnly: false,
                                    style: TextStyle(color: Color(0xffC9CACC)),
                                    decoration: InputDecoration(
                                      hintText: "NIFTY 50",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text("is"),
                        SizedBox(
                          height: 6.h,
                        ),
                        Container(
                          height: 48.h,
                          child: DropdownButtonFormField<String>(
                            value: selectedCondition,
                            items: [
                              "Greater than or equal to (>=)",
                              "Less than or equal to (<=)",
                              "Equal to (==)"
                            ]
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCondition = value!;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("than"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                SizedBox(
                                  height: 48.h,
                                  width: 150.w,
                                  child: TextField(
                                    controller: priceController,
                                    style: TextStyle(color: Color(0xffC9CACC)),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      hintText: '22913.15',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("% of last price"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                SizedBox(
                                  height: 48.h,
                                  width: 150.w,
                                  child: TextField(
                                    controller: percentageController,
                                    style: TextStyle(color: Color(0xffC9CACC)),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      hintText: '0.0',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Spacer(),
              ],
            ),
          ),
          bottomNavigationBar: constWidgets.greenButton("Create"),
        ),
      ),
    );
  }
}
