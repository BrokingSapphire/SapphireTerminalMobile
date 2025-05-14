import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sapphire/screens/home/trades/commodity/closedTrades/closedCommodityList.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String action;
  final String status;
  final String postedDateTime;
  final double entryPrice;
  final double exitRangeMin;
  final double exitRangeMax;
  final double target;
  final double netGain;

  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.action,
    required this.status,
    required this.postedDateTime,
    required this.entryPrice,
    required this.exitRangeMin,
    required this.exitRangeMax,
    required this.target,
    required this.netGain,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      symbol: json['symbol'],
      companyName: json['company_name'],
      logo: json['logo'],
      action: json['action'],
      status: json['status'],
      postedDateTime: json['posted_date_time'],
      entryPrice: json['entry_price'].toDouble(),
      exitRangeMin: json['exit_range_min'].toDouble(),
      exitRangeMax: json['exit_range_max'].toDouble(),
      target: json['target'].toDouble(),
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
      'posted_date_time': postedDateTime,
      'entry_price': entryPrice,
      'exit_range_min': exitRangeMin,
      'exit_range_max': exitRangeMax,
      'target': target,
      'net_gain': netGain,
    };
  }
}

// Sample ClosedComGridScreen (replace with your actual implementation)
class ClosedComGridScreen extends StatelessWidget {
  final List<Map<String, dynamic>> trades;

  const ClosedComGridScreen({super.key, required this.trades});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.75,
      ),
      itemCount: trades.length,
      itemBuilder: (context, index) {
        final trade = trades[index];
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xff121413),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade['logo']),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    trade['symbol'],
                    style: TextStyle(
                      color: const Color(0xffEBEEF5),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                trade['company_name'],
                style:
                    TextStyle(color: const Color(0xffC9CACC), fontSize: 11.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Action: ${trade['action']}',
                style:
                    TextStyle(color: const Color(0xffEBEEF5), fontSize: 11.sp),
              ),
              Text(
                'Status: ${trade['status']}',
                style:
                    TextStyle(color: const Color(0xffEBEEF5), fontSize: 11.sp),
              ),
              Text(
                'Net Gain: ${trade['net_gain'] >= 0 ? '+' : ''}${trade['net_gain']}%',
                style: TextStyle(
                  color: trade['net_gain'] >= 0 ? Colors.green : Colors.red,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TradesComClosedScreen extends StatefulWidget {
  const TradesComClosedScreen({super.key});

  @override
  State<TradesComClosedScreen> createState() => _TradesComClosedScreenState();
}

class _TradesComClosedScreenState extends State<TradesComClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 75.0;
  bool isGridView = true; // Default view mode
  final TextEditingController _searchController = TextEditingController();

  // Dummy JSON data
  final List<Map<String, dynamic>> tradeData = [
    {
      'symbol': 'RELIANCE',
      'company_name': 'Reliance Industries Ltd.',
      'logo': 'assets/images/reliance logo.png',
      'action': 'BUY',
      'status': 'Target Miss',
      'posted_date_time': '14 Feb 2025 | 8:32 pm',
      'entry_price': 1580.60,
      'exit_range_min': 407.00,
      'exit_range_max': 510.00,
      'target': 1752.12,
      'net_gain': 6.08,
    },
    {
      'symbol': 'TCS',
      'company_name': 'Tata Consultancy Services Ltd.',
      'logo': 'assets/images/tcs logo.png',
      'action': 'BUY',
      'status': 'Target Hit',
      'posted_date_time': '15 Feb 2025 | 10:15 am',
      'entry_price': 4200.50,
      'exit_range_min': 4100.00,
      'exit_range_max': 4300.00,
      'target': 4500.00,
      'net_gain': -2.35,
    },
  ];

  // Convert JSON data to TradeModel objects
  late final List<TradeModel> trades =
      tradeData.map((json) => TradeModel.fromJson(json)).toList();

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
                              child: SvgPicture.asset(
                                'assets/svgs/list.svg',
                                color:
                                    !isGridView ? Colors.green : Colors.white,
                                width: 18.w,
                                height: 18.h,
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
                            ? ClosedComListScreen(
                                trades: filteredTrades
                                    .map((trade) => trade.toMap())
                                    .toList(),
                              )
                            : ClosedComGridScreen(
                                trades: filteredTrades
                                    .map((trade) => trade.toMap())
                                    .toList(),
                              ),
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
