import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sapphire/screens/home/trades/future/ClosedFutureGridScreen.dart';
import 'package:sapphire/screens/home/trades/future/ClosedFutureListScreen.dart';
import 'package:sapphire/screens/home/trades/stock/ClosedGridScreen.dart';
import 'package:sapphire/screens/home/trades/stock/ClosedListScreen.dart';

class TradesFutureClosedScreen extends StatefulWidget {
  const TradesFutureClosedScreen({super.key});

  @override
  State<TradesFutureClosedScreen> createState() => _TradesFutureClosedScreen();
}

class _TradesFutureClosedScreen extends State<TradesFutureClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 75.0;
  bool isGridView = true; // Default view mode

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),

                // Stats Container
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: Color(0xff021813),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color(0xff02d8b1),
                      width: 1, // Set border size to 2
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              statTextUp('Avg Return/Trade', '₹4,284'),
                              SizedBox(height: 8.h),
                              statTextUp('Avg Return/Month', '₹48,284'),
                            ],
                          ),
                          CircularPercentIndicator(
                            radius: 43.r,
                            lineWidth: 15.w,
                            percent:
                                ((dynamicPercent ?? 0).clamp(0, 100)) / 100,
                            center: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${(dynamicPercent ?? 0).toStringAsFixed(1)}%\n',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 11
                                          .sp, // Larger font size for percentage
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Accuracy',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 8
                                          .sp, // Smaller font size for "Accuracy"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            progressColor: const Color(0xff4FF4AF),
                            backgroundColor: const Color(0XFFFF504C),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Divider(color: Color(0xff2F2F2F)),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          statText('Closed Trades', '205'),
                          statText('Avg Duration', '4 days'),
                          statText('Avg Margin/Trade', '₹48,284'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Search & Toggle View
                Row(
                  children: [
                    // Search Bar
                    Expanded(
                        child: Text(
                      "Closed trades (246)",
                      style: TextStyle(fontSize: 12.sp),
                    )),

                    SizedBox(width: 10.w),

                    // Toggle Buttons
                    Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border:
                            Border.all(color: Color(0xff2F2F2F)), // Grey border
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: ToggleButtons(
                          renderBorder: false, // Removes vertical divider
                          borderRadius:
                              BorderRadius.circular(8.r), // Rounded corners
                          isSelected: [isGridView, !isGridView],
                          onPressed: (index) {
                            setState(() {
                              isGridView = index == 0;
                            });
                          },
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.grid_view_rounded,
                                color: isGridView
                                    ? Colors.green
                                    : Colors.white, // Green when selected
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.filter_list_outlined,
                                color: !isGridView
                                    ? Colors.green
                                    : Colors.white, // Green when selected
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Display GridView or ListView
                Container(
                    height: 400.h, // Ensures the content has enough space
                    child: isGridView
                        ? ClosedFutureListScreen()
                        : ClosedFutureGridScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper Widgets
Widget tradeDetailRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(color: Color(0xffEBEEF5), fontSize: 13.sp),
      ),
      Text(
        value,
        style: GoogleFonts.poppins(
          color: Color(0xffEBEEF5),
          fontSize: 13.sp,
        ),
      ),
    ],
  );
}

Widget statText(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(color: Color(0xffC9CACC), fontSize: 11.sp),
      ),
      Text(
        value,
        style: GoogleFonts.poppins(
          color: Color(0xffEBEEF5),
          fontSize: 11.sp,
        ),
      ),
    ],
  );
}

Widget statTextUp(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(color: Color(0xffC9CACC), fontSize: 13.sp),
      ),
      Text(
        value,
        style: GoogleFonts.poppins(
          color: Color(0xffEBEEF5),
          fontSize: 13.sp,
        ),
      ),
    ],
  );
}
