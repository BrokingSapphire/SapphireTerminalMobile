import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class SettingsOrderPreference extends StatefulWidget {
  const SettingsOrderPreference({super.key});

  @override
  State<SettingsOrderPreference> createState() =>
      _SettingsOrderPreferenceState();
}

class _SettingsOrderPreferenceState extends State<SettingsOrderPreference> {
  double width = 0;

  // Default chip selections for each section
  // Keys are section titles, values are default chip labels
  Map<String, String> selectedProductType = {
    "Equity Cash": "Delivery", // Default: Delivery
    "Equity Derivatives": "CarryForward", // Default: CarryForward
    "Currency Derivatives": "CarryForward", // Default: CarryForward
    "Commodity Derivatives": "CarryForward", // Default: CarryForward
  };
  Map<String, String> selectedOrderType = {
    "Equity Cash": "Market", // Default: Limit
    "Equity Derivatives": "Market", // Default: Limit
    "Currency Derivatives": "Market", // Default: Limit
    "Commodity Derivatives": "Market", // Default: Limit
  };

  List equityCash = ["Equity Cash", "Delivery", "Intraday", "Retail"];
  List equityDerivatives = [
    "Equity Derivatives",
    "CarryForward",
    "Intraday",
    "Retail"
  ];
  List currDerivatives = [
    "Currency Derivatives",
    "CarryForward",
    "Intraday",
    "Retail"
  ];
  List commDerivatives = [
    "Commodity Derivatives",
    "CarryForward",
    "Intraday",
    "Retail"
  ];

  Widget sections(List list, bool isDark) {
    String sectionTitle = list[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black),
        ),
        SizedBox(height: 16.h),
        Text(
          "Product Type",
          style: TextStyle(
              color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
              fontSize: 13.sp),
        ),
        SizedBox(height: 14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProductType[sectionTitle] = list[1];
                });
              },
              child: constWidgets.choiceChip(
                list[1],
                selectedProductType[sectionTitle] == list[1],
                context,
                width,
                isDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProductType[sectionTitle] = list[2];
                });
              },
              child: constWidgets.choiceChip(
                list[2],
                selectedProductType[sectionTitle] == list[2],
                context,
                width,
                isDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProductType[sectionTitle] = list[3];
                });
              },
              child: constWidgets.choiceChip(
                list[3],
                selectedProductType[sectionTitle] == list[3],
                context,
                width,
                isDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Text(
          "Order Type",
          style: TextStyle(
              color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
              fontSize: 13.sp),
        ),
        SizedBox(height: 14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOrderType[sectionTitle] = "Limit";
                });
              },
              child: constWidgets.choiceChip(
                "Limit",
                selectedOrderType[sectionTitle] == "Limit",
                context,
                width,
                isDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOrderType[sectionTitle] = "Market";
                });
              },
              child: constWidgets.choiceChip(
                "Market",
                selectedOrderType[sectionTitle] == "Market",
                context,
                width,
                isDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOrderType[sectionTitle] = "Retain";
                });
              },
              child: constWidgets.choiceChip(
                "Retain",
                selectedOrderType[sectionTitle] == "Retain",
                context,
                width,
                isDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Divider(
          color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 3 - 20;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Order Preference",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
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
                  color: isDark ? Colors.white : Colors.black)),
        ),
      ),
      body: Column(
        children: [
          // Fixed Divider
          Divider(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    sections(equityCash, isDark),
                    SizedBox(height: 24.h),
                    sections(equityDerivatives, isDark),
                    SizedBox(height: 24.h),
                    sections(currDerivatives, isDark),
                    SizedBox(height: 24.h),
                    sections(commDerivatives, isDark),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          height: 44.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF1DB954),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              "SAVE",
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
