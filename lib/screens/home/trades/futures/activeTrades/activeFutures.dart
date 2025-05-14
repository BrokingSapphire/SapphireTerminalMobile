// File: activeFutures.dart
// Description: Futures trading screen for the Sapphire Trading application.
// This screen displays active futures trades with detailed price information, entry ranges, targets, and allows users to view trade details or place orders.

import 'dart:convert'; // For JSON parsing
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/screens/home/trades/trades.dart'; // Trade utilities and shared components

/// TradeModel - Model class to represent a futures trade
/// Contains all relevant information about a single futures trade
class TradeModel {
  final String symbol; // Stock symbol/ticker
  final String companyName; // Full company name
  final String logo; // Path to company logo asset
  final String action; // Trade action (BUY/SELL)
  final double currentPrice; // Current market price
  final double change; // Price change amount
  final double percentageChange; // Percentage change in price
  final bool isPositive; // Whether the price change is positive
  final double entryPrice; // Recommended entry price
  final double entryRangeMin; // Minimum recommended entry price
  final double entryRangeMax; // Maximum recommended entry price
  final String postedDate; // Date when the trade was posted
  final String postedTime; // Time when the trade was posted
  final double target; // Target price for the trade
  final String holdDuration; // Recommended holding period
  final double netGain; // Current net gain/loss percentage

  /// Constructor to initialize all trade properties
  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.action,
    required this.currentPrice,
    required this.change,
    required this.percentageChange,
    required this.isPositive,
    required this.entryPrice,
    required this.entryRangeMin,
    required this.entryRangeMax,
    required this.postedDate,
    required this.postedTime,
    required this.target,
    required this.holdDuration,
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
      currentPrice: json['current_price'].toDouble(),
      change: json['change'].toDouble(),
      percentageChange: json['percentage_change'].toDouble(),
      isPositive: json['is_positive'],
      entryPrice: json['entry_price'].toDouble(),
      entryRangeMin: json['entry_range_min'].toDouble(),
      entryRangeMax: json['entry_range_max'].toDouble(),
      postedDate: json['posted_date'],
      postedTime: json['posted_time'],
      target: json['target'].toDouble(),
      holdDuration: json['hold_duration'],
      netGain: json['net_gain'].toDouble(),
    );
  }
}

/// TradesFutureActiveScreen - Widget that displays active futures trades
/// Shows trade cards with detailed information and action buttons
class TradesFutureActiveScreen extends StatefulWidget {
  const TradesFutureActiveScreen({super.key});

  @override
  State<TradesFutureActiveScreen> createState() =>
      _TradesFutureActiveScreenState();
}

/// State class for the TradesFutureActiveScreen widget
/// Manages the display of active futures trades and their interactions
class _TradesFutureActiveScreenState extends State<TradesFutureActiveScreen>
    with SingleTickerProviderStateMixin {

  /// Loads trade data from a simulated JSON source
  /// In a production environment, this would fetch data from an API
  /// @return Future<List<TradeModel>> - A Future that resolves to a list of trade models
  Future<List<TradeModel>> loadTrades() async {
    // Dummy JSON data embedded in the file for demonstration purposes
    const jsonString = '''
    [
      {
        "symbol": "RELIANCE",
        "company_name": "Reliance Industries Ltd.",
        "logo": "assets/images/reliance logo.png",
        "action": "BUY",
        "current_price": 580.60,
        "change": 0.55,
        "percentage_change": 1.33,
        "is_positive": true,
        "entry_price": 1200.00,
        "entry_range_min": 1198.00,
        "entry_range_max": 1273.00,
        "posted_date": "15 Feb 2025",
        "posted_time": "03:17 pm",
        "target": 1380.00,
        "hold_duration": "1 - 3 months",
        "net_gain": 6.08
      },
      {
        "symbol": "TCS",
        "company_name": "Tata Consultancy Services Ltd.",
        "logo": "assets/images/tcs logo.png",
        "action": "BUY",
        "current_price": 4200.50,
        "change": 50.25,
        "percentage_change": 1.21,
        "is_positive": false,
        "entry_price": 4250.00,
        "entry_range_min": 4200.00,
        "entry_range_max": 4300.00,
        "posted_date": "16 Feb 2025",
        "posted_time": "02:45 pm",
        "target": 4500.00,
        "hold_duration": "2 - 4 months",
        "net_gain": -1.15
      }
    ]
    ''';
    // Parse JSON data and convert to TradeModel objects
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => TradeModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
        EdgeInsets.only(right: 16.w, left: 16.h, top: 16.w, bottom: 8.w),
        child: FutureBuilder<List<TradeModel>>(
          future: loadTrades(), // Load trade data asynchronously
          builder: (context, snapshot) {
            // Handle different states of the Future
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while data is being fetched
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Show error message if data fetching fails
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Show message if no trades are available
              return const Center(child: Text('No trades available'));
            }

            // Display trades when data is available
            final trades = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header showing the count of active trades
                Text(
                  "Active Trades (${trades.length})",
                  style: TextStyle(
                      color: const Color(0xffEBEEF5), fontSize: 15.sp),
                ),
                SizedBox(height: 8.h),
                // Trade cards - showing one with positive gain and one with loss
                activeTradeCard(trades[0]), // First trade (gain)
                SizedBox(height: 12.h),
                activeLossTradeCard(trades[1]), // Second trade (loss)
              ],
            );
          },
        ),
      ),
    );
  }

  /// Creates a card widget displaying detailed information about a futures trade with positive gain
  /// @param trade - The trade model containing all trade details
  /// @return Widget - A styled card with trade information and action buttons
  Widget activeTradeCard(TradeModel trade) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company logo, name and action tag
              Row(
                children: [
                  // Company logo
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logo),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Company name and ticker with action tag
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Stock ticker/symbol
                          Text(
                            trade.symbol,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          // Action tag (BUY/SELL)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff1db954).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              trade.action,
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
                      // Full company name
                      Text(
                        trade.companyName,
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              // Current price and change information
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Current price
                  Text(
                    "₹${trade.currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Price change with indicator (up arrow for positive)
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/icon-park-solid_up-one.svg",
                        width: 12.sp,
                        height: 12.sp,
                        color: const Color(0xff1db954),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${trade.change.toStringAsFixed(2)} (${trade.percentageChange.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xff1db954),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// Entry Price - Recommended entry price for the trade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}",
                  style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range - Recommended price range for entry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Range", style: _labelStyle()),
              Text(
                  "₹${trade.entryRangeMin.toStringAsFixed(2)} - ${trade.entryRangeMax.toStringAsFixed(2)}",
                  style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Color(0xff2F2F2f)),

          /// Posted, Target, Hold Duration in a row - Additional trade details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Posted date and time information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text("${trade.postedDate} | ${trade.postedTime}",
                      style: _valueStyle()),
                ],
              ),
              // Target price information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text("₹${trade.target.toStringAsFixed(2)}",
                      style: _valueStyle()),
                ],
              ),
              // Recommended holding duration
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hold Duration", style: _labelStyle()),
                  Text(trade.holdDuration, style: _valueStyle()),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net Gain - Current performance indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xff3a3a3a).withOpacity(0.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Net gain: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
                // Positive gain displayed in green with + sign
                Text(
                  "+${trade.netGain.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          /// Action Buttons - About Trade and Place Order
          Row(
            children: [
              // About Trade button - Shows detailed trade information
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement trade details view
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff2F2F2F)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      "About Trade",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Place Order button - Shows order confirmation dialog
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xff1db954)),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Creates a card widget displaying detailed information about a futures trade with negative gain (loss)
  /// Similar to activeTradeCard but with different styling for negative values
  /// @param trade - The trade model containing all trade details
  /// @return Widget - A styled card with trade information and action buttons showing loss indicators
  Widget activeLossTradeCard(TradeModel trade) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row - Logo + Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company logo, name and action tag
              Row(
                children: [
                  // Company logo
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logo),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Company name and ticker with action tag
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Stock ticker/symbol
                          Text(
                            trade.symbol,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          // Action tag (BUY/SELL)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff1db954).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              trade.action,
                              style: TextStyle(
                                color: const Color(0xff1db954),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        trade.companyName,
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              // Current price and change information
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Current price
                  Text(
                    "₹${trade.currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // Price change with indicator (down arrow for negative, flipped up arrow)
                  Row(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform:
                        Matrix4.rotationX(3.1416), // 180° flip on X-axis to create down arrow
                        child: SvgPicture.asset(
                          "assets/svgs/icon-park-solid_up-one.svg",
                          width: 12.sp,
                          height: 12.sp,
                          color: const Color(0xffe53935), // Red for negative change
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${trade.change.toStringAsFixed(2)} (${trade.percentageChange.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xffe53935), // Red for negative change
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// Entry Price - Recommended entry price for the trade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}",
                  style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range - Recommended price range for entry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Range", style: _labelStyle()),
              Text(
                  "₹${trade.entryRangeMin.toStringAsFixed(2)} - ${trade.entryRangeMax.toStringAsFixed(2)}",
                  style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Color(0xff2F2F2f)),

          /// Posted, Target, Hold Duration in a row - Additional trade details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Posted date and time information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text("${trade.postedDate} | ${trade.postedTime}",
                      style: _valueStyle()),
                ],
              ),
              // Target price information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text("₹${trade.target.toStringAsFixed(2)}",
                      style: _valueStyle()),
                ],
              ),
              // Recommended holding duration
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hold Duration", style: _labelStyle()),
                  Text(trade.holdDuration, style: _valueStyle()),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Net Gain - Current performance indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xff3a3a3a).withOpacity(0.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Net gain: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
                // Net gain value with appropriate sign and color based on positive/negative value
                Text(
                  "${trade.netGain >= 0 ? '+' : ''}${trade.netGain.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: trade.netGain >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          /// Action Buttons - About Trade and Place Order
          Row(
            children: [
              // About Trade button - Shows detailed trade information
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement trade details view
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff2F2F2F)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      "About Trade",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Place Order button - Shows order confirmation dialog
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            TradesUtils.placeOrderPopup(context),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff1db954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: const BorderSide(color: Color(0xff1db954)),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xffEBEEF5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Helper method for consistent label text style
  /// @return TextStyle - Style for label texts
  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  /// Helper method for consistent value text style
  /// @return TextStyle - Style for value texts
  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}