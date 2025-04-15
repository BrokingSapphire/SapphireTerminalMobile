import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/orders/Gtt3Screen.dart';
import '../../../utils/constWidgets.dart';

class gtt2Screen extends StatefulWidget {
  const gtt2Screen({super.key});

  @override
  State<gtt2Screen> createState() => _gtt2ScreenState();
}

class _gtt2ScreenState extends State<gtt2Screen> {
  TextEditingController mybasketname = TextEditingController();
  final List<Map<String, dynamic>> stocks = [
    {
      "ltp": "₹1,226.90",
      "type": "BUY",
      "price": "₹1,580.60",
      "quantity": "1",
      "tags": ["SINGLE"],
    },
    {
      "ltp": "₹1,226.90",
      "type": "BUY",
      "price": "₹1,580.60",
      "quantity": "1",
      "tags": ["SINGLE"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 38,
        title:
            Text("GTT", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.h), // Controls the height of the divider
          child: Divider(
            color: Colors.grey.shade800, // Light grey divider for contrast
            thickness: 1, // Divider thickness
            height: 1, // Ensures it sticks to the bottom of the AppBar
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            constWidgets.searchField(context, "Search GTT", "orders"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    navi(gtt3Screen(), context);
                  },
                  child: Text(
                    "+ New GTT",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  final stock = stocks[index];
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Color(0xff143520),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    stock['type'],
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("RELIANCE",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("LTP ${stock['ltp']}",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Color(0xffC9CACC))),
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
                          stocks.length - 1) // Show divider only between items
                        Divider(
                          color: Color(0xff2f2f2f),
                          thickness: 1, // Divider thickness
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
