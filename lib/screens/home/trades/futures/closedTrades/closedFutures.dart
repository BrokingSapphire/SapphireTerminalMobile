import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sapphire/screens/home/trades/futures/closedTrades/closedFuturesGrid.dart';
import 'package:sapphire/screens/home/trades/futures/closedTrades/closedFuturesList.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String action;
  final String status;
  final double entryPrice;
  final String entryDateTime;
  final double exitPrice;
  final String exitDateTime;
  final double netGain;

  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.action,
    required this.status,
    required this.entryPrice,
    required this.entryDateTime,
    required this.exitPrice,
    required this.exitDateTime,
    required this.netGain,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      symbol: json['symbol'],
      companyName: json['company_name'],
      logo: json['logo'],
      action: json['action'],
      status: json['status'],
      entryPrice: json['entry_price'].toDouble(),
      entryDateTime: json['entry_date_time'],
      exitPrice: json['exit_price'].toDouble(),
      exitDateTime: json['exit_date_time'],
      netGain: json['net_gain'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'company_name': companyName,
      'logo': logo,
      'action': action,
      'status': status,
      'entry_price': entryPrice,
      'entry_date_time': entryDateTime,
      'exit_price': exitPrice,
      'exit_date_time': exitDateTime,
      'net_gain': netGain,
    };
  }
}

class TradesFutureClosedScreen extends StatefulWidget {
  const TradesFutureClosedScreen({super.key});

  @override
  State<TradesFutureClosedScreen> createState() =>
      _TradesFutureClosedScreenState();
}

class _TradesFutureClosedScreenState extends State<TradesFutureClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 75.0;
  bool isGridView = true; // Default view mode
  final TextEditingController _searchController = TextEditingController();

  // Dummy JSON data
  final List<Map<String, dynamic>> futureData = [
    {
      'symbol': 'RELIANCE',
      'company_name': 'Reliance Industries Ltd.',
      'logo': 'assets/images/reliance logo.png',
      'action': 'BUY',
      'status': 'Target Miss',
      'entry_price': 1580.60,
      'entry_date_time': '14 Feb 2025 | 8:32 pm',
      'exit_price': 1752.12,
      'exit_date_time': '15 Feb 2025 | 9:32 pm',
      'net_gain': 6.08,
    },
    {
      'symbol': 'TCS',
      'company_name': 'Tata Consultancy Services Ltd.',
      'logo': 'assets/images/tcs logo.png',
      'action': 'BUY',
      'status': 'Target Hit',
      'entry_price': 4200.50,
      'entry_date_time': '13 Feb 2025 | 10:15 am',
      'exit_price': 4100.75,
      'exit_date_time': '14 Feb 2025 | 3:45 pm',
      'net_gain': -2.35,
    },
  ];

  // Convert JSON data to TradeModel objects
  late final List<TradeModel> trades =
      futureData.map((json) => TradeModel.fromJson(json)).toList();

  // Filtered list for search results
  late List<TradeModel> filteredTrades;

  @override
  void initState() {
    super.initState();
    // Initialize filtered list with all trades
    filteredTrades = List.from(trades);
    // Enforce uppercase in TextField
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
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
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
                            percent: ((dynamicPercent ?? 0).clamp(0, 100)) / 100,
                            center: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${(dynamicPercent ?? 0).toStringAsFixed(1)}%\n',
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
                SizedBox(height: 12.h),

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
                              // Filter trades based on search query
                              if (value.isEmpty) {
                                filteredTrades = List.from(trades);
                              } else {
                                filteredTrades = trades.where((trade) {
                                  final symbolMatch = trade.symbol
                                      .toLowerCase()
                                      .startsWith(value.toLowerCase());
                                  final nameMatch = trade.companyName
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
                              child: Icon(
                                Icons.filter_list_outlined,
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
                    "Closed Trades (${filteredTrades.length})",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 15.sp),
                  ),
                ),
                SizedBox(height: 8.h),

                // Display search results or message if no results
                filteredTrades.isEmpty
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
                                'No trades found',
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
                            ? ClosedFutureListScreen(
                                trades: filteredTrades
                                    .map((trade) => trade.toMap())
                                    .toList(),
                              )
                            : ClosedFutureGridScreen(),
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
