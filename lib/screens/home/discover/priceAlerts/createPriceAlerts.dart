import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/priceAlerts/priceAlertSearch.dart';

import '../../../../utils/constWidgets.dart';

class createAlertScreen extends StatefulWidget {
  @override
  _createAlertScreenState createState() => _createAlertScreenState();
}

class _createAlertScreenState extends State<createAlertScreen> {
  String selectedPriceType = "Last price";
  String selectedCondition = "Greater than or equal to (>=)";
  final TextEditingController priceController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 24.w,
          title: Padding(
            padding: EdgeInsets.only(
              top: 15.w,
            ),
            child: Text(
              "Create New Alert",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.h),
            child: Column(
              children: [
                Divider(
                  height: 1,
                  color: isDark
                      ? const Color(0xff2F2F2F)
                      : const Color(0xffD1D5DB),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.h,
                ),
                InkWell(
                  onTap: () {
                    navi(const PriceAlertSearchScreen(), context);
                  },
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF121413),
                      // border: Border.all(
                      //     color: isDark ? Colors.transparent : Colors.grey),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 22.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Search Stock',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                      "High price",
                                      "Low price",
                                      "Open price",
                                      "Close price",
                                      "Day change",
                                      "Day change %",
                                      "Intraday change",
                                      "Avg. traded price",
                                      "Volume",
                                      "Total buy qty.",
                                      "Total sell qty.",
                                      "OI day low"
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
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
                                      ),
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
                                    readOnly: true,
                                    style: TextStyle(color: Color(0xffC9CACC)),
                                    decoration: InputDecoration(
                                      hintText: "NIFTY 50",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
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
                              "Greater than (>)",
                              "Less than or equal to (<=)",
                              "Less than (<)",
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
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide:
                                    BorderSide(color: Color(0xff2f2f2f)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(color: Colors.white),
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
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
                                            BorderRadius.circular(6.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Color(0xff2f2f2f)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: 10.sp,
          ),
          child: constWidgets.greenButton("Create"),
        ),
      ),
    );
  }
}
