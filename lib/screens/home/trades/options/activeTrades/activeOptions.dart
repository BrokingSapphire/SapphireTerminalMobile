// File: activeOptions.dart
// Description: Options trading screen for the Sapphire Trading application.
// This screen displays active options trades with strategy details including buy/sell positions, entry/exit prices, and profit/loss information.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/screens/home/trades/trades.dart'; // Trade utilities and shared components

/// TradeModel - Model class to represent an options trade
/// Contains detailed information about options trade strategies with buy/sell positions
class TradeModel {
  final String symbol; // Stock symbol/ticker
  final String companyName; // Full company name
  final String logo; // Path to company logo asset
  final String optionName; // Option contract details (e.g., "RELIANCE 1200 CE")
  final String action; // Trade action (BUY/SELL)
  final String postedDateTime; // When the trade was posted
  final String strategyBuy; // Buy leg of the options strategy
  final String strategySell; // Sell leg of the options strategy
  final double entryBuyPrice; // Entry price for buy leg
  final double entrySellPrice; // Entry price for sell leg
  final double exitBuyPrice; // Exit price for buy leg
  final double exitSellPrice; // Exit price for sell leg
  final double stoplossAmount; // Maximum loss amount
  final double targetAmount; // Target profit amount
  final double netGain; // Current net gain/loss percentage

  /// Constructor to initialize all trade properties
  TradeModel({
    required this.symbol,
    required this.companyName,
    required this.logo,
    required this.optionName,
    required this.action,
    required this.postedDateTime,
    required this.strategyBuy,
    required this.strategySell,
    required this.entryBuyPrice,
    required this.entrySellPrice,
    required this.exitBuyPrice,
    required this.exitSellPrice,
    required this.stoplossAmount,
    required this.targetAmount,
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
      optionName: json['option_name'],
      action: json['action'],
      postedDateTime: json['posted_date_time'],
      strategyBuy: json['strategy_buy'],
      strategySell: json['strategy_sell'],
      entryBuyPrice: json['entry_buy_price'].toDouble(),
      entrySellPrice: json['entry_sell_price'].toDouble(),
      exitBuyPrice: json['exit_buy_price'].toDouble(),
      exitSellPrice: json['exit_sell_price'].toDouble(),
      stoplossAmount: json['stoploss_amount'].toDouble(),
      targetAmount: json['target_amount'].toDouble(),
      netGain: json['net_gain'].toDouble(),
    );
  }
}

/// TradesOptionActiveScreen - Widget that displays active options trades
/// Shows detailed options strategy cards with buy/sell positions and price information
class TradesOptionActiveScreen extends StatefulWidget {
  const TradesOptionActiveScreen({super.key});

  @override
  State<TradesOptionActiveScreen> createState() =>
      _TradesOptionActiveScreenState();
}

/// State class for the TradesOptionActiveScreen widget
/// Manages the display of active options trades and their interactions
class _TradesOptionActiveScreenState extends State<TradesOptionActiveScreen>
    with SingleTickerProviderStateMixin {
  // Sample trade data for demonstration purposes
  // In a production environment, this would be fetched from an API
  final List<Map<String, dynamic>> tradeData = [
    {
      'symbol': 'RELIANCE',
      'company_name': 'Reliance Industries Ltd.',
      'logo': 'assets/images/reliance logo.png',
      'option_name': 'RELIANCE 1200 CE',
      'action': 'BUY',
      'posted_date_time': '08 May 2025 | 09:45 Am',
      'strategy_buy': '14 Feb 440 CE',
      'strategy_sell': '14 Feb 440 CE',
      'entry_buy_price': 1580.60,
      'entry_sell_price': 1580.60,
      'exit_buy_price': 1580.60,
      'exit_sell_price': 1580.60,
      'stoploss_amount': -1580.60,
      'target_amount': 1580.60,
      'net_gain': 6.08,
    },
    {
      'symbol': 'TCS',
      'company_name': 'Tata Consultancy Services Ltd.',
      'logo': 'assets/images/tcs logo.png',
      'option_name': 'TCS 4000 CE',
      'action': 'BUY',
      'posted_date_time': '07 May 2025 | 10:30 Am',
      'strategy_buy': '15 Feb 450 CE',
      'strategy_sell': '15 Feb 450 CE',
      'entry_buy_price': 4200.50,
      'entry_sell_price': 4200.50,
      'exit_buy_price': 4100.75,
      'exit_sell_price': 4100.75,
      'stoploss_amount': -4200.50,
      'target_amount': 4500.00,
      'net_gain': -2.35,
    },
  ];

  // Convert JSON data to TradeModel objects for easier handling in the UI
  late final List<TradeModel> trades =
  tradeData.map((json) => TradeModel.fromJson(json)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
        EdgeInsets.only(right: 16.w, left: 16.h, top: 16.w, bottom: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header showing the count of active trades
            Text(
              "Active Trades (${trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            // List of option trade cards
            for (var i = 0; i < trades.length; i++) ...[
              buildTradeCard(trades[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  /// Creates a card widget displaying detailed information about an options trade
  /// @param trade - The trade model containing all trade details
  /// @return Widget - A styled card with options trade strategy information and action buttons
  Widget buildTradeCard(TradeModel trade) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with option details and posting date
          Row(
            children: [
              // Company logo/initial
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xff2A2A2A),
                child: Text(
                  trade.symbol[0], // First letter of the stock symbol
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Option contract name and date information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Option contract identifier (e.g., "RELIANCE 1200 CE")
                  Text(
                    trade.optionName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Trade date
                  Text(
                    trade.postedDateTime.split(' | ')[0], // Just the date part
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 11.h),

          // Posted timestamp with enhanced styling
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Posted ",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 11.sp,
                  ),
                ),
                TextSpan(
                  text: trade.postedDateTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 11.h),

          // Table headers for Strategy, Entry, Exit columns
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Strategy", // Strategy column header
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Entry", // Entry price column header
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Exit", // Exit price column header
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // BUY strategy row with entry and exit prices
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // BUY tag with green styling
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xff22a06b).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "BUY",
                        style: TextStyle(
                          color: const Color(0xff22a06b),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Buy option contract details (e.g., "14 Feb 440 CE")
                    Text(
                      trade.strategyBuy,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              // Entry price for buy leg
              Expanded(
                child: Text(
                  "₹${trade.entryBuyPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // Exit price for buy leg
              Expanded(
                child: Text(
                  "₹${trade.exitBuyPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // SELL strategy row with entry and exit prices
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // SELL tag with red styling
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "SELL",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Sell option contract details (e.g., "14 Feb 440 CE")
                    Text(
                      trade.strategySell,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Entry price for sell leg
              Expanded(
                child: Text(
                  "₹${trade.entrySellPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              // Exit price for sell leg
              Expanded(
                child: Text(
                  "₹${trade.exitSellPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Divider(height: 1.h, color: const Color(0xff2F2F2F)),
          SizedBox(height: 10.h),

          // Risk management section - Stoploss and Target amounts
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stoploss amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stoploss amount",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "₹${trade.stoplossAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // Target amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Target amount",
                    style: TextStyle(
                      color: const Color(0xffC9CACC),
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "₹${trade.targetAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Net gain indicator - Shows profit/loss with color coding
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xff2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Net gain: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  // Profit/loss value with appropriate color (green for profit, red for loss)
                  TextSpan(
                    text:
                    "${trade.netGain >= 0 ? '+' : ''}${trade.netGain.toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: trade.netGain >= 0
                          ? const Color(0xff1db954) // Green for profit
                          : Colors.red, // Red for loss
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Action buttons - About Trade and Place Order
          Row(
            children: [
              // About Trade button - Shows trade details
              Expanded(
                child: Container(
                  height: 40.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement trade details view
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff595959)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "About Trade",
                      style: TextStyle(
                        color: const Color(0xffEBEEF5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Place Order button - Shows order confirmation dialog
              Expanded(
                child: Container(
                  height: 40.h,
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
                      side: const BorderSide(color: Color(0xff1db954)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        color: Color(0xffEBEEF5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method for creating a row with three aligned columns
  /// @param title - Title text for the first column
  /// @param val1 - Value text for the second column
  /// @param val2 - Value text for the third column
  /// @return Widget - A styled three-column row
  Widget buildTripleColumnRow(String title, String val1, String val2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: _labelStyle()),
        ),
        Expanded(
          flex: 3,
          child: Text(val1, style: _valueStyle(), textAlign: TextAlign.start),
        ),
        Expanded(
          flex: 3,
          child: Text(val2, style: _valueStyle(), textAlign: TextAlign.end),
        ),
      ],
    );
  }

  /// Helper method for creating a row with two aligned columns
  /// @param title - Title text for the first column
  /// @param val1 - Value text for the second column
  /// @param val2 - Value text for the third column
  /// @return Widget - A styled two-column row
  Widget buildDoubleColumnRow(String title, String val1, String val2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: _labelStyle()),
        ),
        Expanded(
          flex: 3,
          child: Text(val1, style: _valueStyle(), textAlign: TextAlign.start),
        ),
        Expanded(
          flex: 3,
          child: Text(val2, style: _valueStyle(), textAlign: TextAlign.end),
        ),
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