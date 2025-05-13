import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocksGrid.dart';
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocksList.dart';

class tradesClosedScreen extends StatefulWidget {
  const tradesClosedScreen({super.key});

  @override
  State<tradesClosedScreen> createState() => _tradesClosedScreenState();
}

class _tradesClosedScreenState extends State<tradesClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 50.0;
  bool isGridView = true; // Default view mode

  // List of stock data for search functionality
  final List<Map<String, String>> stocksData = [
    {
      "symbol": "RELIANCE",
      "companyName": "Reliance Industries Ltd.",
      "action": "BUY"
    },
    {
      "symbol": "TCS",
      "companyName": "Tata Consultancy Services Ltd.",
      "action": "SELL"
    },
    {"symbol": "DABUR", "companyName": "Dabur India Ltd.", "action": "BUY"},
    {"symbol": "DLF", "companyName": "DLF Limited", "action": "SELL"},
    {"symbol": "RECLTD", "companyName": "REC Limited", "action": "BUY"},
    {"symbol": "INFY", "companyName": "Infosys Ltd.", "action": "BUY"}
  ];

  final List<Map<String, String>> closedStocksData = [
    {
      "symbol": "RELIANCE",
      "companyName": "Reliance Industries Ltd.",
      "action": "BUY",
      "logo": "reliance logo.png",
    },
    {
      "symbol": "TCS",
      "companyName": "Tata Consultancy Services Ltd.",
      "action": "SELL",
      "logo": "tcs logo.png",
    },
  ];
  // Filtered list for search results
  List<Map<String, String>> filteredStocks = [];

  @override
  void initState() {
    super.initState();
    // Initialize filtered list with all stocks
    filteredStocks = List.from(stocksData);
  }

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
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                //   decoration: BoxDecoration(
                //     color: Color(0xff021813),
                //     borderRadius: BorderRadius.circular(12.r),
                //     border: Border.all(
                //       color: Color(0xff02d8b1),
                //       width: 1, // Set border size to 2
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               statTextUp('Avg Return/Trade', '₹4,284'),
                //               SizedBox(height: 8.h),
                //               statTextUp('Avg Return/Month', '₹48,284'),
                //             ],
                //           ),
                //           CircularPercentIndicator(
                //             radius: 43.r,
                //             lineWidth: 15.w,
                //             percent:
                //                 ((dynamicPercent ?? 0).clamp(0, 100)) / 100,
                //             center: RichText(
                //               textAlign: TextAlign.center,
                //               text: TextSpan(
                //                 children: [
                //                   TextSpan(
                //                     text:
                //                         '${(dynamicPercent ?? 0).toStringAsFixed(1)}%\n',
                //                     style: GoogleFonts.poppins(
                //                       color: Colors.white,
                //                       fontSize: 11
                //                           .sp, // Larger font size for percentage
                //                       fontWeight: FontWeight.w500,
                //                     ),
                //                   ),
                //                   TextSpan(
                //                     text: 'Accuracy',
                //                     style: GoogleFonts.poppins(
                //                       color: Colors.white,
                //                       fontSize: 8
                //                           .sp, // Smaller font size for "Accuracy"
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             progressColor: const Color(0xff4FF4AF),
                //             backgroundColor: const Color(0XFFFF504C),
                //             circularStrokeCap: CircularStrokeCap.round,
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: 2.h),
                //       Divider(color: Color(0xff2F2F2F)),
                //       SizedBox(height: 2.h),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           statText('Closed Trades', '205'),
                //           statText('Avg Duration', '4 days'),
                //           statText('Avg Margin/Trade', '₹48,284'),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 16.h),
                // Search & Toggle View
                Row(
                  children: [
                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TextField(
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (value) {
                            setState(() {
                              // Filter stocks based on search query
                              if (value.isEmpty) {
                                // If search is empty, show all stocks
                                filteredStocks = List.from(stocksData);
                              } else {
                                // Filter stocks by symbol or company name
                                filteredStocks = stocksData.where((stock) {
                                  final symbolMatch = stock["symbol"]!
                                      .toLowerCase()
                                      .startsWith(value.toLowerCase());
                                  final nameMatch = stock["companyName"]!
                                      .toLowerCase()
                                      .contains(value.toLowerCase());
                                  return symbolMatch || nameMatch;
                                }).toList();
                              }
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff121413),
                            hintText: "Search by name or ticker",
                            hintStyle: TextStyle(
                                color: Color(0xffC9CACC), fontSize: 14.sp),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 5.w), // Adds space before the icon
                              child: SvgPicture.asset(
                                'assets/svgs/search-svgrepo-com (1).svg',
                                // Update with your actual SVG path
                                width: 18.w, // Adjust size
                                height: 18.h,
                                color: Colors.grey, // Change color if needed
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 36.w,
                              // Ensure enough space for padding to take effect
                              minHeight: 36.h,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xff141213)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xff141213)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xff141213)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xff141213)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 8.w), // Reduce horizontal padding
                          ),
                          style: TextStyle(color: Color(0xffEBEEF5)),
                        ),
                      ),
                    ),

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
                          renderBorder: false,
                          // Removes vertical divider
                          borderRadius: BorderRadius.circular(8.r),
                          // Rounded corners
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
                              // child: Icon(
                              //   Icons.filter_list_outlined,
                              //   color: !isGridView
                              //       ? Colors.green
                              //       : Colors.white, // Green when selected
                              // ),
                              child: SvgPicture.asset("assets/svgs/list.svg",
                                  color: !isGridView
                                      ? Colors.green
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Closed Trade(${closedStocksData.length})",
                      style: TextStyle(
                          color: const Color(0xffEBEEF5), fontSize: 15.sp),
                    )),
                SizedBox(
                  height: 8.h,
                ),

                // Display search results or message if no results
                filteredStocks.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/search-svgrepo-com (1).svg',
                                width: 50.w,
                                height: 50.h,
                                color: Color(0xff2F2F2F),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No stocks found',
                                style: TextStyle(
                                  color: Color(0xffC9CACC),
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: 700.h, // Ensures the content has enough space
                        child: isGridView
                            ? ClosedListScreen(filteredStocks: closedStocksData)
                            : closedGridScreen(filteredStocks: filteredStocks),
                      ),
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
