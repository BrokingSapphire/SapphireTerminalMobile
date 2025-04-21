import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class MutualFundsScreen extends StatefulWidget {
  const MutualFundsScreen({super.key});

  @override
  State<MutualFundsScreen> createState() => _MutualFundsScreenState();
}

class _MutualFundsScreenState extends State<MutualFundsScreen> {
  List<Map<String, dynamic>> mutualFundsData = [
    {
      "title": "MOTILAL OSWAL MIDCAP FUND",
      "category": "Regular · Growth · Mid Cap",
      "invested": "₹1,00,000",
      "returns": "-3,979.60 (-12.2%)",
      "isGain": false,
      "icon": Icons.wb_sunny,
    },
    {
      "title": "ICICI PRUDENTIAL NIFTY 50 INDEX FUND",
      "category": "Regular · Growth · Large Cap",
      "invested": "₹5,00,000",
      "returns": "+3,979.60 (+12.2%)",
      "isGain": true,
      "icon": Icons.info,
    },
    {
      "title": "FRANKLIN INDIA SMALLER COMPANIES FUND",
      "category": "Regular · Growth · Small Cap",
      "invested": "₹2,00,000",
      "returns": "-3,979.60 (-12.2%)",
      "isGain": false,
      "icon": Icons.wb_sunny,
    },
  ];

  Widget mutualFundCard(
      String firtTitle,
      String firstValue,
      String secondTitle,
      String secondValue,
      bool isDark,
      String thirdTitle,
      String thirdValue,
      String fourthTitle,
      String fourthValue) {
    return Column(
      children: [
        Container(
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
                      firtTitle,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    Text(
                      firstValue,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black),
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
                              color: isDark ? Colors.white : Colors.black,
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
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
            )),
        Container(
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
                      thirdTitle,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    Text(
                      thirdValue,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      fourthTitle,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: fourthValue,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: fourthValue.contains('-')
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
                SizedBox(height: 16.h),

                // Summary Card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    height: 145.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: isDark
                            ? const Color(0xFF121413)
                            : const Color(0xFFF4F4F9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        constWidgets.singleCard("Current Value", '₹15,11,750',
                            "Overall Loss", "-₹45,096", isDark),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Divider(
                            color: isDark
                                ? const Color(0xff2F2F2F)
                                : const Color(0xffD1D5DB),
                            thickness: 1,
                          ),
                        ),
                        Container(
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
                                      "Invested Value",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "₹19,91,071",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "XIRR",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "-6.75%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17.sp,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // 👉 Replace this with your actual custom search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: constWidgets.searchField(context,
                      "Search Mutual Funds....", "mutual_funds", isDark),
                ),

                SizedBox(height: 16.h),

                if (mutualFundsData.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 150.h,
                            width: 150.w,
                            child: Image.asset(
                                "assets/emptyPng/holdingsMutualFunds.png")),
                        Text(
                          "No Mutual Fund Investment",
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            "Invest in mutual funds and grow your wealth over time.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mutualFundsData.length,
                          itemBuilder: (context, index) {
                            var data = mutualFundsData[index];
                            return _fundTile(
                              title: data['title'],
                              category: data['category'],
                              invested: data['invested'],
                              returns: data['returns'],
                              isGain: data['isGain'],
                              icon: data['icon'],
                              isDark: isDark,
                            );
                          },
                        )
                      ]),
              ],
            ),
          ),
        ));
  }

  Widget _summaryRow(String lTitle, String lVal, String rTitle, String rVal,
      {required bool isGain}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryCol(lTitle, lVal, isGain: true),
        _summaryCol(rTitle, rVal, isGain: isGain),
      ],
    );
  }

  Widget _summaryCol(String title, String value, {required bool isGain}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isGain ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _fundTile({
    required String title,
    required String category,
    required String invested,
    required String returns,
    required bool isGain,
    required IconData icon,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left indicator bar
              Container(
                width: 2.w,
                height: 90.h,
                color: isGain ? Colors.green : Colors.red,
              ),

              // Main content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fund title & category
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 4),
                                Text(category,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          // Top right icon inside circular background
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: const Color(0xFFEDEDED),
                            // child: Icon(icon, color: Colors.red, size: 16),
                            child: Image.asset(
                              "assets/images/reliance logo.png",
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Invested value
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Invested value",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp)),
                              Text(invested,
                                  style: TextStyle(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontSize: 14.sp)),
                            ],
                          ),
                          // Returns
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Returns",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.sp)),
                              Text(
                                returns,
                                style: TextStyle(
                                    color: isGain ? Colors.green : Colors.red,
                                    fontSize: 13.sp),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
        )
      ],
    );
  }
}
