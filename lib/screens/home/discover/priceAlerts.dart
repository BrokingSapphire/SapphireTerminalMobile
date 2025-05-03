import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/createPriceAlerts.dart';
import '../../../utils/naviWithoutAnimation.dart';

class PriceAlerts extends StatefulWidget {
  const PriceAlerts({super.key});

  @override
  State<PriceAlerts> createState() => _PriceAlertsState();
}

class _PriceAlertsState extends State<PriceAlerts> {
  // Sample data for alerts
  final List<Map<String, dynamic>> alerts = [
    {
      'symbol': 'NIFTY 50',
      'condition': 'Last price of NIFTY 50(INDICES) >= 25,000.00',
      'isActive': true,
    },
    {
      'symbol': 'NIFTY 50',
      'condition': 'Last price of NIFTY 50(INDICES) >= 25,000.00',
      'isActive': true,
    },
    {
      'symbol': 'NIFTY 50',
      'condition': 'Last price of NIFTY 50(INDICES) >= 25,000.00',
      'isActive': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        leadingWidth: 38.w,
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Price Alerts",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xffC9CACC),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              navi(createAlertScreen(), context);
            },
            icon: Icon(Icons.add, color: isDark ? Colors.white : Colors.black),
          )
        ],
      ),
      body: alerts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 48.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "No alerts created yet",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Create alerts to get notified when stocks reach your target price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Color(0xFF2F2F2F),
                  thickness: 1.h,
                  height: 1.h,
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text("Alerts (${alerts.length})",
                      style: TextStyle(fontSize: 13.sp, color: Colors.white)),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (int i = 0; i < alerts.length; i++) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      alerts[i]['symbol'],
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      alerts[i]['condition'],
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Color(0xffC9CACC),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Active",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Color(0xffC9CACC),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Add divider after each item except the last one
                        Divider(
                          height: 1,
                          color: Color(0xFF2F2F2F),
                        ),
                      ],
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0xFF2F2F2F),
                ),
              ],
            ),
      floatingActionButton: alerts.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                navi(createAlertScreen(), context);
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
