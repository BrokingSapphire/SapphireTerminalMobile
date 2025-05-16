import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/stockDetailedWindow/mutualFundsDetails.dart';
import 'package:sapphire/utils/constWidgets.dart';

class MutualFundsScreen extends StatefulWidget {
  const MutualFundsScreen({super.key});

  @override
  State<MutualFundsScreen> createState() => _MutualFundsScreenState();
}

class _MutualFundsScreenState extends State<MutualFundsScreen> {
  // Text controller for search field
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Map<String, dynamic>> mutualFundsData = [
    {
      "title": "MOTILAL OSWAL MIDCAP FUND ",
      "category": "Regular · Growth · Mid Cap",
      "invested": "₹1,00,000",
      "returns": "-3,979.60 (-12.2%)",
      "isGain": false,
      "icon": Icons.wb_sunny,
    },
    {
      "title": "ICICI PRUDENTIAL NIFTY 50 INDEX FUND ",
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

  // Get filtered and sorted mutual funds data
  List<Map<String, dynamic>> _getFilteredMutualFundsData() {
    // Sort the mutual funds data alphabetically by name
    List<Map<String, dynamic>> sortedMutualFundsData =
        List.from(mutualFundsData);
    sortedMutualFundsData
        .sort((a, b) => a["title"].toString().compareTo(b["title"].toString()));

    // Filter based on search query
    if (_searchQuery.isEmpty) {
      return sortedMutualFundsData;
    }

    // Return only funds that start with the search query
    return sortedMutualFundsData.where((fund) {
      return fund["title"]
          .toString()
          .toUpperCase()
          .startsWith(_searchQuery.toUpperCase());
    }).toList();
  }

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
                      secondValue.contains('-')
                          ? "Overall Loss"
                          : "Overall Gain",
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
    // Get filtered mutual funds data
    final filteredMutualFundsData = _getFilteredMutualFundsData();
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
          onRefresh: () async {
            // Add your refresh logic here
          },
          color: const Color(0xff1DB954), // Green refresh indicator
          backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
          child: filteredMutualFundsData.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 64.h,
                            width: 64.w,
                            child:
                                SvgPicture.asset("assets/svgs/doneMark.svg")),
                        SizedBox(height: 20.h),
                        Text("No Mutual Fund Investments",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black)),
                        SizedBox(height: 10.h),
                        SizedBox(
                            width: 250.w,
                            child: Text(
                                "Invest in mutual funds and grow your wealth over time.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.grey))),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
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
                              constWidgets.singleCard(
                                  "Current Value",
                                  '₹15,11,750',
                                  "Overall Loss",
                                  "-₹45,096",
                                  isDark),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                      fontWeight:
                                                          FontWeight.w600,
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

                      // Search field with input functionality
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: constWidgets.searchFieldWithInput(context,
                            "Search Mutual Funds....", "mutual_funds", isDark,
                            controller: _searchController, onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        }),
                      ),

                      SizedBox(height: 16.h),

                      ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredMutualFundsData.length,
                              itemBuilder: (context, index) {
                                var data = filteredMutualFundsData[index];
                                return GestureDetector(
                                  onTap: () {
                                    navi(MutualFundsDetails(), context);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: _fundTile(
                                    title: data['title'],
                                    category: data['category'],
                                    invested: data['invested'],
                                    returns: data['returns'],
                                    isGain: data['isGain'],
                                    icon: data['icon'],
                                    isDark: isDark,
                                  ),
                                );
                              },
                            )
                          ]),
                    ],
                  ),
                ),
        ));
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
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    )),
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
