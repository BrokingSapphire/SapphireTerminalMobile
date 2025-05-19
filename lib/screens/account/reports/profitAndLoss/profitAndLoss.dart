import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class ProfitAndLoss extends StatefulWidget {
  const ProfitAndLoss({super.key});

  @override
  State<ProfitAndLoss> createState() => _ProfitAndLossState();
}

class _ProfitAndLossState extends State<ProfitAndLoss>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int selectedTab = 0;
  List<String> tabs = ["Equity", "F&O", "Currency", "Commodity"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget tabBarContent(String name, int index) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
          _tabController.animateTo(index);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color(0xff1db954) : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Color(0xff1db954) : Color(0xFFC9CACC),
          ),
        ),
      ),
    );
  }

  Widget tiles(String name, String subtitle, String subtitle2, String subtitle3,
      String col1, String col2, String col3, String col4) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xffC9CACC),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          subtitle2,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xffC9CACC),
                          ),
                        ),
                        Text(
                          subtitle3,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xff1db954),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        col1,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xffC9CACC),
                        ),
                      ),
                      Text(
                        col2,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xff1db954),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        col3,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xffC9CACC),
                        ),
                      ),
                      Text(
                        col4,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(
            height: 1,
            color: Color(0xff2F2F2F),
            thickness: 1,
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> getTabData(int index) {
    switch (index) {
      case 0: // Equity
        return [
          {
            'name': 'RELIANCE',
            'subtitle': 'Reliance Industries Ltd.',
            'netPL': '+₹1,256.89',
            'realizedPL': '+₹1,456.89',
            'charges': '-₹200.00'
          },
          {
            'name': 'HDFCBANK',
            'subtitle': 'HDFC Bank Ltd.',
            'netPL': '-₹458.65',
            'realizedPL': '-₹398.65',
            'charges': '-₹60.00'
          },
        ];
      case 1: // F&O
        return [
          {
            'name': 'NIFTY 21MAR 22000 CE',
            'subtitle': 'NSE Index Options',
            'netPL': '+₹2,568.45',
            'realizedPL': '+₹2,768.45',
            'charges': '-₹200.00'
          },
          {
            'name': 'BANKNIFTY FUT',
            'subtitle': 'NSE Index Futures',
            'netPL': '-₹1,245.78',
            'realizedPL': '-₹1,145.78',
            'charges': '-₹100.00'
          },
        ];
      case 2: // Currency
        return [
          {
            'name': 'USDINR MAR FUT',
            'subtitle': 'USD/INR Futures',
            'netPL': '+₹856.45',
            'realizedPL': '+₹956.45',
            'charges': '-₹100.00'
          },
          {
            'name': 'EURINR MAR FUT',
            'subtitle': 'EUR/INR Futures',
            'netPL': '-₹245.78',
            'realizedPL': '-₹195.78',
            'charges': '-₹50.00'
          },
        ];
      case 3: // Commodity
        return [
          {
            'name': 'GOLDM MAR FUT',
            'subtitle': 'Gold Mini Futures',
            'netPL': '+₹3,568.45',
            'realizedPL': '+₹3,768.45',
            'charges': '-₹200.00'
          },
          {
            'name': 'CRUDEOIL MAR FUT',
            'subtitle': 'Crude Oil Futures',
            'netPL': '-₹1,845.78',
            'realizedPL': '-₹1,745.78',
            'charges': '-₹100.00'
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Profit & Loss",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xff2F2F2F),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(16.h),
                        decoration: BoxDecoration(
                          color: Color(0xff121413),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gross Realised P&L",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xffC9CACC),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Charges",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xffC9CACC),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "-₹13,456.78",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "₹2,000",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.all(12.h),
                              decoration: BoxDecoration(
                                color: Color(0xff252525),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Net Realised P&L",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "(Realised P&L - Charges)",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xffC9CACC),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹456.78",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Color(0xff1db954),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trade and Charges Summary for",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "10 Feb 2025 - 17 Feb 2025",
                                style: TextStyle(
                                  color: Color(0xff1db954),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff1db954),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      constWidgets.searchField(
                          context, "Search company or stock", "equity", isDark),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                // Tab bar without horizontal padding
                CustomTabBar(tabController: _tabController, options: tabs),
                SizedBox(height: 5.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: getTabData(selectedTab).length,
                      itemBuilder: (context, index) {
                        final data = getTabData(selectedTab)[index];
                        return tiles(
                          data['name']!,
                          data['subtitle']!,
                          'Net P&L: ',
                          data['netPL']!,
                          'Realized P&L: ',
                          data['realizedPL']!,
                          'Charges: ',
                          data['charges']!,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
