import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  Widget stockDetailRow(String leftText, String rightText) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: TextStyle(fontSize: 11.sp, color: Color(0xffC9CACC)),
        ),
        Text(
          rightText,
          style: TextStyle(
              fontSize: 11.sp,
              color: isDark ? Color(0xffEBEEF5) : Color(0xffEBEEF5)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leadingWidth: 28,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "PETRONET",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff303030),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "NSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff1db954).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "BUY",
                    style: TextStyle(
                      color: const Color(0xff1db954),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff1db954).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "EXECUTED",
                    style: TextStyle(
                      color: const Color(0xff1db954),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                text: "1256.89 ",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.white : Color(0xff6B7280)),
                children: [
                  TextSpan(
                    text: "(+1.67%)",
                    style: TextStyle(fontSize: 13.sp, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 6.h),
          Divider(
            height: 1.h,
            color: Color(0xff2f2f2f),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Filed Qty.",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "1500/1500",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Avg. Price",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "327.00",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xffC9CACC)),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "MARKET",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/createAlertOrderDetails.svg",
                              color: Color(0xff1db954),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              " Set Alert",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/optionChainOrderDetails.svg",
                              colorFilter: ColorFilter.mode(
                                Color(0xff1db954),
                                BlendMode.srcIn,
                              ),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Option Chain",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/createGtt.svg",
                              colorFilter: ColorFilter.mode(
                                Color(0xff1db954),
                                BlendMode.srcIn,
                              ),
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Create GTT",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Color(0xffEBEEF5)
                                      : Color(0xffEBEEF5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Stock Details",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: isDark
                                        ? Color(0xffEBEEF5)
                                        : Color(0xffEBEEF5)),
                              ),
                            ),
                            SizedBox(height: 13.h),
                            stockDetailRow("Validity / Product", "Day / NRML"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Status", "COMPLETED"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Price", "0.00"),
                            SizedBox(height: 12.h),
                            stockDetailRow("User", "JQN407"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Trigger price", "0.00"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Time", "2025-05-15 22:00:00"),
                            SizedBox(height: 12.h),
                            stockDetailRow(
                                "Exchange Time", "2025-05-15 22:00:00"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Order ID", "195868461864684"),
                            SizedBox(height: 12.h),
                            stockDetailRow("Exchange ID", "651648348468"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/viewChart.svg",
                                  colorFilter: ColorFilter.mode(
                                    Color(0xff1db954),
                                    BlendMode.srcIn,
                                  ),
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "View Chart",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: isDark
                                          ? Color(0xffEBEEF5)
                                          : Color(0xffEBEEF5)),
                                ),
                              ],
                            ),
                          )),
                          Container(
                            width: 1.w,
                            height: 25.h,
                            color: Color(0xff2f2f2f),
                          ),
                          Expanded(
                              child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/stockDetails.svg",
                                  colorFilter: ColorFilter.mode(
                                    Color(0xff1db954),
                                    BlendMode.srcIn,
                                  ),
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "Stock Details",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: isDark
                                          ? Color(0xffEBEEF5)
                                          : Color(0xffEBEEF5)),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff2f2f2f)),
                  color: Color(0xff2f2f2f),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                height: 40.h,
                child: Center(
                  child: Text("View Position"),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1DB954),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                height: 40.h,
                child: Center(
                  child: Text("Reorder"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
