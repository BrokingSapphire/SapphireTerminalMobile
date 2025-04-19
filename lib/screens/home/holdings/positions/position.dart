import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class positionScreen extends StatefulWidget {
  const positionScreen({super.key});

  @override
  State<positionScreen> createState() => _positionScreenState();
}

class _positionScreenState extends State<positionScreen> {
  List<Map<String, dynamic>> positionData = [
    {
      "title": "ALKYLAMINE",
      "midtitle": "Alklyl Amines Chemical Tech",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE",
      "midtitle": "Alklyl Amines Chemical Tech",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "59 Qty × Avg 2,670.84",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: isDark
                        ? const Color(0xFF121413)
                        : const Color(0xFFF4F4F9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      constWidgets.singleCard("Total Gain", '₹15,11,750',
                          "Total Loss", "-₹45,096", isDark),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: constWidgets.searchField(
                  context, "Search Everything...", "positions", isDark),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (positionData.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 150.h,
                        width: 150.w,
                        child: Image.asset(
                            "assets/emptyPng/holdingsPosition.png")),
                    Text(
                      "No Open Positions",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        "Your active trades will be listed here. Start trading today!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: positionData.length,
                        itemBuilder: (context, index) {
                          var data = positionData[index];
                          return positionScreenTiles(
                            data['title'],
                            data['midtitle'],
                            data['subtitle'],
                            data['trail1'],
                            data['trail2'],
                            data['trail3'],
                            data['isBuy'],
                            isDark,
                          );
                        })
                  ])
          ],
        ),
      ),
    );
  }

  Widget positionScreenTiles(
    String title,
    String midtitle,
    String subtitle,
    String trail1,
    String trail2,
    String trail3,
    bool isBuy,
    bool isDark,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 95.h,
            child: Row(
              children: [
                Container(
                    height: 75.h,
                    width: 2.w,
                    color: trail1.startsWith("-") ? Colors.red : Colors.green),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      midtitle,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trail1,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: trail1.startsWith("-")
                              ? Colors.red
                              : Colors.green),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: isBuy
                            ? (isDark
                                ? Color(0xff143520)
                                : Colors.green.withOpacity(0.2))
                            : (isDark
                                ? Color(0xff3A0C0C)
                                : Color(0xffFF0000).withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        trail2,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isBuy ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color:
                            isDark ? Color(0xff333333) : Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        trail3,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
        )
      ],
    );
  }
}
