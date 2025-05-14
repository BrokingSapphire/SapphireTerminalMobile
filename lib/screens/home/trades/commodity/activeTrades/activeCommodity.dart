import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/trades/trades.dart';

class TradeModel {
  final String symbol;
  final String companyName;
  final String logo;
  final String action;
  final double currentPrice;
  final double change;
  final double percentageChange;
  final double entryPrice;
  final double entryRangeMin;
  final double entryRangeMax;
  final String postedDateTime;
  final double target;
  final String holdDuration;
  final double netGain;

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

class TradesComActiveScreen extends StatefulWidget {
  const TradesComActiveScreen({super.key});

  @override
  State<TradesComActiveScreen> createState() => _TradesComActiveScreenState();
}

class _TradesComActiveScreenState extends State<TradesComActiveScreen>
    with SingleTickerProviderStateMixin {
  // Dummy JSON data defined directly as a List<Map<String, dynamic>>
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

  // Convert JSON data to TradeModel objects
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
            Text(
              "Active Trades (${trades.length})",
              style: TextStyle(color: const Color(0xffEBEEF5), fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            for (var i = 0; i < trades.length; i++) ...[
              activeTradeCard(trades[i]),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(trade.logo),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            trade.symbol,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xffEBEEF5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6.w),
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
                      Text(
                        trade.companyName,
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${trade.currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xffEBEEF5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.rotationX(trade.change >= 0 ? 0 : math.pi),
                        child: SvgPicture.asset(
                          "assets/svgs/icon-park-solid_up-one.svg",
                          width: 12.sp,
                          height: 12.sp,
                          color: trade.change >= 0
                              ? const Color(0xff1db954)
                              : const Color(0xffe53935),
                        ),
                      ),
                      SizedBox(width: 4.w),
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

          /// Entry Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Entry Price", style: _labelStyle()),
              Text("₹${trade.entryPrice.toStringAsFixed(2)}",
                  style: _valueStyle()),
            ],
          ),
          SizedBox(height: 8.h),

          /// Entry Range
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

          /// Posted, Target, Hold Duration in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text(trade.postedDateTime, style: _valueStyle()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Target", style: _labelStyle()),
                  Text("₹${trade.target.toStringAsFixed(2)}",
                      style: _valueStyle()),
                ],
              ),
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

          /// Net Gain
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

          /// Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: () {},
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
