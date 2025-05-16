// File: closedFutures.dart
// Description: Closed futures trades screen for the Sapphire Trading application.
// This screen displays completed futures trades with search functionality and toggle between grid and list views.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:google_fonts/google_fonts.dart'; // For custom typography
import 'package:sapphire/screens/home/trades/futures/closedTrades/closedFuturesGrid.dart'; // Grid view for closed futures trades
import 'package:sapphire/screens/home/trades/futures/closedTrades/closedFuturesList.dart'; // List view for closed futures trades

/// TradeModel - Model class to represent a closed futures trade
/// Contains all relevant information about a completed futures trade
class TradeModel {
  final String symbol; // Futures contract symbol/ticker
  final String companyName; // Company/entity name
  final String logo; // Path to logo asset
  final String action; // Trade action (BUY/SELL)
  final String status; // Trade outcome status (Target Hit/Miss)
  final double entryPrice; // Price at which the trade was entered
  final String entryDateTime; // Date and time when the trade was entered
  final double exitPrice; // Price at which the trade was exited
  final String exitDateTime; // Date and time when the trade was exited
  final double netGain; // Net gain/loss percentage from the trade

  /// Constructor to initialize all trade properties
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
      entryPrice: json['entry_price'].toDouble(),
      entryDateTime: json['entry_date_time'],
      exitPrice: json['exit_price'].toDouble(),
      exitDateTime: json['exit_date_time'],
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
      'entry_price': entryPrice,
      'entry_date_time': entryDateTime,
      'exit_price': exitPrice,
      'exit_date_time': exitDateTime,
      'net_gain': netGain,
    };
  }
}

/// TradesFutureClosedScreen - Widget that displays closed futures trades
/// Includes search functionality and toggle between grid and list views
class TradesFutureClosedScreen extends StatefulWidget {
  const TradesFutureClosedScreen({super.key});

  @override
  State<TradesFutureClosedScreen> createState() =>
      _TradesFutureClosedScreenState();
}

/// State class for the TradesFutureClosedScreen widget
/// Manages the display of closed futures trades, search filtering, and view mode toggle
class _TradesFutureClosedScreenState extends State<TradesFutureClosedScreen>
    with SingleTickerProviderStateMixin {
  double dynamicPercent = 75.0; // For accuracy indicator (currently unused)
  bool isGridView = true; // Default view mode - true for grid, false for list
  final TextEditingController _searchController = TextEditingController(); // Controller for search input

  // Sample futures trade data for demonstration purposes
  // In a production environment, this would be fetched from an API
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

  // Convert JSON data to TradeModel objects for easier handling in the UI
  late final List<TradeModel> trades =
  futureData.map((json) => TradeModel.fromJson(json)).toList();

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
                SizedBox(height: 12.h),

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
                              child: Icon(
                                Icons.filter_list_outlined,
                                color:
                                !isGridView ? Colors.green : Colors.white, // Highlight when selected
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
                      ? // Show list view for futures trades
                  ClosedFutureListScreen(
                    trades: filteredTrades
                        .map((trade) => trade.toMap())
                        .toList(),
                  )
                      : // Show grid view for futures trades
                  ClosedFutureGridScreen(),
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