// File: activeCommodity.dart
// Description: Commodity trading screen for the Sapphire Trading application.
// This screen displays active commodity trades with detailed information and provides options to view trade details or place orders.

import 'dart:math' as math; // For PI constant used in rotation transformation
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/screens/home/trades/trades.dart'; // Trade utilities and shared components

/// TradeModel - Model class to represent a commodity trade
/// Contains all relevant information about a single commodity trade
class TradeModel {
  final String symbol; // Commodity symbol/ticker
  final String companyName; // Company/entity name
  final String logo; // Path to logo asset
  final String action; // Trade action (BUY/SELL)
  final double currentPrice; // Current market price
  final double change; // Price change amount
  final double percentageChange; // Percentage change in price
  final double entryPrice; // Recommended entry price
  final double entryRangeMin; // Minimum recommended entry price
  final double entryRangeMax; // Maximum recommended entry price
  final String postedDateTime; // When the trade was posted
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
    required this.entryPrice,
    required this.entryRangeMin,
    required this.entryRangeMax,
    required this.postedDateTime,
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
      entryPrice: json['entry_price'].toDouble(),
      entryRangeMin: json['entry_range_min'].toDouble(),
      entryRangeMax: json['entry_range_max'].toDouble(),
      postedDateTime: json['posted_date_time'],
      target: json['target'].toDouble(),
      holdDuration: json['hold_duration'],
      netGain: json['net_gain'].toDouble(),
    );
  }
}

/// TradesComActiveScreen - Widget that displays active commodity trades
/// Shows trade cards with detailed information and action buttons
class TradesComActiveScreen extends StatefulWidget {
  const TradesComActiveScreen({super.key});

  @override
  State<TradesComActiveScreen> createState() => _TradesComActiveScreenState();
}

/// State class for the TradesComActiveScreen widget
/// Manages the display of active commodity trades and their interactions
class _TradesComActiveScreenState extends State<TradesComActiveScreen>
    with SingleTickerProviderStateMixin {
  // Sample trade data for demonstration purposes
  // In a production environment, this would be fetched from an API
  final List<Map<String, dynamic>> tradeData = [
    {
      'symbol': 'RELIANCE',
      'company_name': 'Reliance Industries Ltd.',
      'logo': 'assets/images/reliance logo.png',
      'action': 'BUY',
      'current_price': 580.60,
      'change': 0.55,
      'percentage_change': 1.33,
      'entry_price': 1200.00,
      'entry_range_min': 1198.00,
      'entry_range_max': 1273.00,
      'posted_date_time': '15 Feb 2025 | 03:17 pm',
      'target': 1380.00,
      'hold_duration': '1 - 3 months',
      'net_gain': 6.08,
    },
    {
      'symbol': 'TCS',
      'company_name': 'Tata Consultancy Services Ltd.',
      'logo': 'assets/images/tcs logo.png',
      'action': 'BUY',
      'current_price': 4200.50,
      'change': -50.25,
      'percentage_change': -1.21,
      'entry_price': 4250.00,
      'entry_range_min': 4200.00,
      'entry_range_max': 4300.00,
      'posted_date_time': '16 Feb 2025 | 02:45 pm',
      'target': 4500.00,
      'hold_duration': '2 - 4 months',
      'net_gain': -1.15,
    },
  ];

  // Convert JSON data to TradeModel objects for easier handling in the UI
  late final List<TradeModel> trades =
  tradeData.map((json) => TradeModel.fromJson(json)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header showing the count of active trades
            Text(
              "Active Trades (${trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            // List of commodity trade cards
            for (var i = 0; i < trades.length; i++) ...[
              activeTradeCard(trades[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  /// Creates a card widget displaying detailed information about a commodity trade
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
                          // Commodity symbol/ticker
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
                  // Price change with dynamic indicator (up/down arrow based on change direction)
                  Row(
                    children: [
                      // Dynamically rotate the arrow based on price change direction
                      Transform(
                        alignment: Alignment.center,
                        transform:
                        Matrix4.rotationX(trade.change >= 0 ? 0 : math.pi), // Rotate 180° if negative
                        child: SvgPicture.asset(
                          "assets/svgs/icon-park-solid_up-one.svg",
                          width: 12.sp,
                          height: 12.sp,
                          // Dynamic color based on change direction (green for positive, red for negative)
                          color: trade.change >= 0
                              ? const Color(0xff1db954)
                              : const Color(0xffe53935),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // Price change text with appropriate sign and color
                      Text(
                        "${trade.change >= 0 ? '+' : ''}${trade.change.toStringAsFixed(2)} (${trade.percentageChange.abs().toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: trade.change >= 0
                              ? const Color(0xff1db954)
                              : const Color(0xffe53935),
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
          Divider(
            color: Color(0xff2F2F2f),
          ),

          /// Posted, Target, Hold Duration in a row - Additional trade details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Posted date and time information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text(trade.postedDateTime, style: _valueStyle()),
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
              // About Trade button - Shows trade details
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

  /// Creates a small stats text widget with title and value
  /// @param title - The label/title to display
  /// @param value - The value to display
  /// @return Widget - A column with styled title and value text
  Widget statsText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(color: const Color(0xffC9CACC), fontSize: 10.sp)),
        Text(value,
            style: TextStyle(
                color: const Color(0xffEBEEF5),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500)),
      ],
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