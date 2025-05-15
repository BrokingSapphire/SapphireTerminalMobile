// File: closedCommodity.dart
// Description: Closed commodity trades screen for the Sapphire Trading application.
// This screen displays completed commodity trades with search functionality and toggle between grid and list views.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:google_fonts/google_fonts.dart'; // For custom typography
import 'package:sapphire/screens/home/trades/commodity/closedTrades/closedCommodityGrid.dart'; // Grid view for closed trades
import 'package:sapphire/screens/home/trades/commodity/closedTrades/closedCommodityList.dart'; // List view for closed trades

/// TradeModel - Model class to represent a closed commodity trade
/// Contains all relevant information about a completed trade
class TradeModel {
  final String symbol; // Commodity symbol/ticker
  final String companyName; // Company/entity name
  final String logo; // Path to logo asset
  final String action; // Trade action (BUY/SELL)
  final String status; // Trade outcome status (Target Hit/Miss)
  final String postedDateTime; // When the trade was posted
  final double entryPrice; // Entry price for the trade
  final double exitRangeMin; // Minimum exit price range
  final double exitRangeMax; // Maximum exit price range
  final double target; // Target price for the trade
  final double netGain; // Net gain/loss percentage

  /// Constructor to initialize all trade properties
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

  /// Factory constructor to create a TradeModel from JSON data
  /// @param json - Map containing trade data
  /// @return TradeModel - Instance created from the JSON data
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

  /// Converts the TradeModel to a Map for passing to child widgets
  /// @return Map<String, dynamic> - Map representation of the trade
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

/// TradesComClosedScreen - Widget that displays closed commodity trades
/// Includes search functionality and toggle between grid and list views
class TradesComClosedScreen extends StatefulWidget {
  const TradesComClosedScreen({super.key});

  @override
  State<TradesComClosedScreen> createState() => _TradesComClosedScreenState();
}

/// State class for the TradesComClosedScreen widget
/// Manages the display of closed commodity trades, search filtering, and view mode toggle
class _TradesComClosedScreenState extends State<TradesComClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 75.0; // For accuracy indicator (currently unused)
  bool isGridView = true; // Default view mode - true for grid, false for list
  final TextEditingController _searchController = TextEditingController(); // Controller for search input

  // Sample trade data for demonstration purposes
  // In a production environment, this would be fetched from an API
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

  // Convert JSON data to TradeModel objects for easier handling in the UI
  late final List<TradeModel> trades =
  tradeData.map((json) => TradeModel.fromJson(json)).toList();

  // Filtered list for search results
  late List<TradeModel> filteredTrades;

  @override
  void initState() {
    super.initState();
    // Initialize filtered list with all trades
    filteredTrades = List.from(trades);

    // Set up listener to enforce uppercase text in search field
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
    // Clean up controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Scaffold(
        body: GestureDetector(
          // Dismiss keyboard when tapping outside of text field
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),

                // Stats Container (currently commented out but can be enabled)
                /*
                // This is a container that would show trade statistics with a circular progress indicator
                // Currently disabled but kept for future implementation
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

                // Search Bar and View Toggle Row
                Row(
                  children: [
                    // Search Bar for filtering trades
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
                                // If search is empty, show all trades
                                filteredTrades = List.from(trades);
                              } else {
                                // Filter by symbol (starts with) or company name (contains)
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

                    // View Toggle Buttons (Grid/List)
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
                          isSelected: [isGridView, !isGridView], // Selection state based on view mode
                          onPressed: (index) {
                            setState(() {
                              // Toggle view mode - 0 for grid, 1 for list
                              isGridView = index == 0;
                            });
                          },
                          children: [
                            // Grid view toggle button
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.grid_view_rounded,
                                color: isGridView ? Colors.green : Colors.white, // Highlight when selected
                              ),
                            ),
                            // List view toggle button
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SvgPicture.asset(
                                'assets/svgs/list.svg',
                                color:
                                !isGridView ? Colors.green : Colors.white, // Highlight when selected
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

                // Closed Trades Count Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Closed Trades (${filteredTrades.length})",
                    style: TextStyle(
                        color: const Color(0xffEBEEF5), fontSize: 15.sp),
                  ),
                ),
                SizedBox(height: 8.h),

                // Display search results or empty state message
                filteredTrades.isEmpty
                    ? // No search results found
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Column(
                      children: [
                        // Empty state icon
                        SvgPicture.asset(
                          'assets/svgs/search-svgrepo-com (1).svg',
                          width: 50.w,
                          height: 50.h,
                          color: Color(0xff2F2F2F),
                        ),
                        SizedBox(height: 16.h),
                        // Empty state message
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
                    : // Trade list/grid based on selected view mode
                Container(
                  height: 700.h,
                  child: isGridView
                      ? // Show list view when grid view is selected (possibly mislabeled or reversed)
                  ClosedComListScreen(
                    trades: filteredTrades
                        .map((trade) => trade.toMap())
                        .toList(),
                  )
                      : // Show grid view when list view is selected (possibly mislabeled or reversed)
                  const ClosedComGridScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper widget for displaying a trade detail row with label and value
/// @param title - The label text
/// @param value - The value text
/// @return Widget - A row with label and value with consistent styling
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

/// Helper widget for displaying a statistic with small text
/// @param title - The label text
/// @param value - The value text
/// @return Widget - A column with label and value with small styling
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

/// Helper widget for displaying a statistic with larger text
/// @param title - The label text
/// @param value - The value text  
/// @return Widget - A column with label and value with larger styling
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