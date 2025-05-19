import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/priceAlerts/createPriceAlerts.dart';

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
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 24.w,
        title: Padding(
          padding: EdgeInsets.only(
            top: 15.w,
          ),
          child: Text(
            "Price Alerts",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
              onPressed: () {
                navi(createAlertScreen(), context);
              },
              icon:
                  Icon(Icons.add, color: isDark ? Colors.white : Colors.black),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.h),
          child: Column(
            children: [
              Divider(
                height: 1,
                color:
                    isDark ? const Color(0xff2F2F2F) : const Color(0xffD1D5DB),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
      body: alerts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 64.h,
                      width: 64.w,
                      child: SvgPicture.asset("assets/svgs/doneMark.svg")),
                  SizedBox(height: 20.h),
                  Text("No Active Price Alerts",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  SizedBox(height: 10.h),
                  SizedBox(
                      width: 250.w,
                      child: Text(
                          "Your set alerts will appear here. Create one to stay updated on price moves!",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.grey))),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    );
  }
}
