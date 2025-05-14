import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocksGrid.dart';
import 'package:sapphire/screens/home/trades/stocks/closedTrades/closedStocksList.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String action;
  final String logo;

  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.action,
    required this.logo,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      symbol: json['symbol'],
      companyName: json['company_name'],
      action: json['action'],
      logo: json['logo'],
    );
  }

  Map<String, String> toMap() {
    return {
      'symbol': symbol,
      'companyName': companyName,
      'action': action,
      'logo': logo,
    };
  }
}

class TradesClosedScreen extends StatefulWidget {
  const TradesClosedScreen({super.key});

  @override
  State<TradesClosedScreen> createState() => _TradesClosedScreenState();
}

class _TradesClosedScreenState extends State<TradesClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 50.0;
  bool isGridView = true; // Default view mode
  final TextEditingController _searchController = TextEditingController();

  // Dummy JSON data defined directly as a List<Map<String, dynamic>>
  final List<Map<String, dynamic>> tradeData = [
    {
      'symbol': 'RELIANCE',
      'company_name': 'Reliance Industries Ltd.',
      'action': 'BUY',
      'logo': 'reliance logo.png',
    },
    {
      'symbol': 'TCS',
      'company_name': 'Tata Consultancy Services Ltd.',
      'action': 'SELL',
      'logo': 'tcs logo.png',
    },
  ];

  // Convert JSON data to TradeModel objects
  late final List<TradeModel> trades =
      tradeData.map((json) => TradeModel.fromJson(json)).toList();

  // Filtered list for search results
  late List<TradeModel> filteredStocks;

  @override
  void initState() {
    super.initState();
    // Initialize filtered list with all trades
    filteredStocks = List.from(trades);
    // Add listener to enforce uppercase
    _searchController.addListener(() {
      final text = _searchController.text;
      if (text != text.toUpperCase()) {
        _searchController.value = _searchController.value.copyWith(
          text: text.toUpperCase(),
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

                // Stats Container (commented out)
                /*
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: Color(0xff021813),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color(0xff02d8b1),
                      width: 1,
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
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Accuracy',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 8.sp,
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
                */
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
                          controller: _searchController,
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (value) {
                            setState(() {
                              // Filter trades based on search query (already uppercase)
                              if (value.isEmpty) {
                                filteredStocks = List.from(trades);
                              } else {
                                filteredStocks = trades.where((stock) {
                                  final symbolMatch = stock.symbol
                                      .toLowerCase()
                                      .startsWith(value.toLowerCase());
                                  final nameMatch = stock.companyName
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
                              padding: EdgeInsets.only(left: 20.w, right: 5.w),
                              child: SvgPicture.asset(
                                'assets/svgs/search-svgrepo-com (1).svg',
                                width: 18.w,
                                height: 18.h,
                                color: Colors.grey,
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 36.w,
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
                                vertical: 10.h, horizontal: 8.w),
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
                        border: Border.all(color: Color(0xff2F2F2F)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: ToggleButtons(
                          renderBorder: false,
                          borderRadius: BorderRadius.circular(8.r),
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
                                color: isGridView ? Colors.green : Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SvgPicture.asset(
                                "assets/svgs/list.svg",
                                color:
                                    !isGridView ? Colors.green : Colors.white,
                              ),
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
                    "Closed Trade(${trades.length})",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 15.sp),
                  ),
                ),
                SizedBox(height: 8.h),

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
                        height: 700.h,
                        child: isGridView
                            ? ClosedListScreen(
                                filteredStocks: filteredStocks
                                    .map((trade) => trade.toMap())
                                    .toList())
                            : closedGridScreen(
                                filteredStocks: filteredStocks
                                    .map((trade) => trade.toMap())
                                    .toList()),
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
