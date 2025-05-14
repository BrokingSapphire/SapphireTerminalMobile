import 'dart:convert';
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
  final bool isPositive;
  final double entryPrice;
  final double entryRangeMin;
  final double entryRangeMax;
  final String postedDate;
  final String postedTime;
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

class TradesFutureActiveScreen extends StatefulWidget {
  const TradesFutureActiveScreen({super.key});

  @override
  State<TradesFutureActiveScreen> createState() =>
      _TradesFutureActiveScreenState();
}

class _TradesFutureActiveScreenState extends State<TradesFutureActiveScreen>
    with SingleTickerProviderStateMixin {
  Future<List<TradeModel>> loadTrades() async {
    // Dummy JSON data embedded in the file
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
          future: loadTrades(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No trades available'));
            }

            final trades = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Trades (${trades.length})",
                  style: TextStyle(
                      color: const Color(0xffEBEEF5), fontSize: 15.sp),
                ),
                SizedBox(height: 8.h),
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
          const Divider(color: Color(0xff2F2F2f)),

          /// Posted, Target, Hold Duration in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text("${trade.postedDate} | ${trade.postedTime}",
                      style: _valueStyle()),
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
                  Row(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.rotationX(3.1416), // 180° flip on X-axis
                        child: SvgPicture.asset(
                          "assets/svgs/icon-park-solid_up-one.svg",
                          width: 12.sp,
                          height: 12.sp,
                          color: const Color(0xffe53935),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${trade.change.toStringAsFixed(2)} (${trade.percentageChange.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xffe53935),
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
          const Divider(color: Color(0xff2F2F2f)),

          /// Posted, Target, Hold Duration in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posted", style: _labelStyle()),
                  Text("${trade.postedDate} | ${trade.postedTime}",
                      style: _valueStyle()),
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

  TextStyle _labelStyle() =>
      TextStyle(color: const Color(0xffC9CACC), fontSize: 13.sp);

  TextStyle _valueStyle() =>
      TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp);
}
