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
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              // Summary Card
              Container(
                height: 145.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: const Color(0xFF121413)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    constWidgets.singleCard("Current Value", '₹15,11,750',
                        "Overall Loss", "-₹45,096"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Divider(
                        color: Color(0xff2F2F2F),
                        thickness: 1,
                      ),
                    ),
                    constWidgets.singleCard("Invested Value", "₹19,91,071",
                        "Today’s Loss", "-₹4,837")
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // 👉 Replace this with your actual custom search bar
              constWidgets.searchField(
                  context, "Search Mutual Funds....", "mutual_funds", isDark),

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
                          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
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
                          );
                        },
                      )
                    ]),
            ],
          ),
        ),
      ),
    );
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
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
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
                                    color: Colors.white,
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
                        radius: 16.r,
                        backgroundColor: const Color(0xFFEDEDED),
                        child: Icon(icon, color: Colors.red, size: 16),
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
                                  color: Colors.white, fontSize: 14.sp)),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
