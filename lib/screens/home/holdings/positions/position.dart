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
      "midtitle": "Alklyl Amines Chemical Ltd",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE",
      "midtitle": "Alklyl Amines Chemical Tech",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CC",
      "midtitle": "24 April 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "INTRADAY",
      "isBuy": false,
    },
    {
      "title": "ALKYLAMINE FUT",
      "midtitle": "27 Mar 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "+3,20,734.12 (+1.5%)",
      "trail2": "BUY",
      "trail3": "INTRADAY",
      "isBuy": true,
    },
    {
      "title": "ALKYLAMINE 1200 CE",
      "midtitle": "24 Apr 2025",
      "subtitle": "1,782 (-2.5%)",
      "trail1": "-3,23,067.14 (-1.5%)",
      "trail2": "SELL",
      "trail3": "CARRYFORWARD",
      "isBuy": false,
    }
  ];

  // Function to get chip colors based on label
  Map<String, Color> _getChipColors(String label) {
    switch (label.toUpperCase()) {
      case 'DELIVERY':
        return {
          'background': Color(0xff1e2e2a),
          'text': Color(0xffa5d6c9),
        };
      case 'INTRADAY':
        return {
          'background': Color(0xff33260d),
          'text': Color(0xffffb74d),
        };
      case 'CARRYFORWARD':
        return {
          'background': Color(0xff1f2537),
          'text': Color(0xff9fa8da),
        };
      case 'MTF':
        return {
          'background': Color(0xff2a1e38),
          'text': Color(0xffce93d8),
        };
      default:
        return {
          'background': Color(0xff1a1a1a),
          'text': Colors.white,
        };
    }
  }

  Widget positionCard(String firstValue, String secondValue, bool isDark) {
    // Determine titles based on values
    String firstTitle = firstValue.contains('-') ? "Total Loss" : "Total Gain";
    String secondTitle =
        secondValue.contains('-') ? "Today's Loss" : "Today's Gain";

    return Container(
      height: 120.h / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstTitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black),
                ),
                Text(
                  firstValue,
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color:
                          firstValue.contains('-') ? Colors.red : Colors.green),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  secondTitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: secondValue,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp,
                            color: secondValue.contains('-')
                                ? Colors.red
                                : Colors.green),
                      ),
                      TextSpan(
                        text: "   ", // Adding spaces for width
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      TextSpan(
                        text: "(-22.51%)",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: secondValue.contains('-')
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
        },
        color: const Color(0xff1DB954), // Green refresh indicator
        backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
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
                            "Today's Loss", "-₹45,096", isDark),
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
    // Get chip colors for trail3
    final chipColors = _getChipColors(trail3);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Container(
            // height: 95.h,
            child: Row(
              children: [
                Container(
                    height: 70.h,
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
                      height: 6.h,
                    ),
                    Text(
                      midtitle,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
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
                          width: 5.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: chipColors['background'],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            trail3,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: chipColors['text'],
                            ),
                          ),
                        ),
                      ],
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
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "LTP :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Quantity :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "365",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
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
