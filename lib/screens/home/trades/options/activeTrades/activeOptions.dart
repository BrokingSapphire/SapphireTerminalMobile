import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String optionName;
  final String action;
  final String postedDateTime;
  final String strategyBuy;
  final String strategySell;
  final double entryBuyPrice;
  final double entrySellPrice;
  final double exitBuyPrice;
  final double exitSellPrice;
  final double stoplossAmount;
  final double targetAmount;
  final double netGain;

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

class TradesOptionActiveScreen extends StatefulWidget {
  const TradesOptionActiveScreen({super.key});

  @override
  State<TradesOptionActiveScreen> createState() =>
      _TradesOptionActiveScreenState();
}

class _TradesOptionActiveScreenState extends State<TradesOptionActiveScreen>
    with SingleTickerProviderStateMixin {
  // Dummy JSON data defined directly as a List<Map<String, dynamic>>
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

  // Convert JSON data to TradeModel objects
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
            Text(
              "Active Trades (${trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            for (var i = 0; i < trades.length; i++) ...[
              buildTradeCard(trades[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

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
          // Header with logo and date
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xff2A2A2A),
                child: Text(
                  trade.symbol[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trade.optionName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    trade.postedDateTime.split(' | ')[0],
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

          // Strategy, Entry, Exit headers
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Strategy",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Entry",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // BUY row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
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

          // SELL row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
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
              Expanded(
                child: Text(
                  "₹${trade.entrySellPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
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

          // Stoploss and Target
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

          // Net gain
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
                  TextSpan(
                    text:
                        "${trade.netGain >= 0 ? '+' : ''}${trade.netGain.toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: trade.netGain >= 0
                          ? const Color(0xff1db954)
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  child: OutlinedButton(
                    onPressed: () {},
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

  /// Helper for aligned 3-column rows
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
