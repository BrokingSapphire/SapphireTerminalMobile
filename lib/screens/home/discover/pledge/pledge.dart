import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sapphire/main.dart';

import 'package:sapphire/screens/home/discover/pledge/history/pledgeHistory.dart';
import 'package:sapphire/screens/home/discover/pledge/pledge/pledgeStocks.dart';
import 'package:sapphire/screens/home/discover/pledge/unpledge/unpledge.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Pledge extends StatefulWidget {
  const Pledge({super.key});

  @override
  State<Pledge> createState() => _PledgeState();
}

class _PledgeState extends State<Pledge> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final options = ['Pledge', 'Unpledge', 'History'];
  List<String> stocks = [];
  bool checked = false;

  int _selectedIndex = 0;

  // Track selected stocks and total amount across tabs
  Map<String, bool> selectedStocks = {};
  double totalSelectedAmount = 0.0;
  String formattedAmount = "";

  // Store all pledge items for correct total calculation
  List<Map<String, dynamic>> _allPledgeItems = [
    {
      'stockName': 'BAJAJ-AUTO',
      'amount': 1995.55,
    },
    {
      'stockName': 'GMRAIRPORT',
      'amount': 1995.55,
    },
    {
      'stockName': 'RELIANCE',
      'amount': 3450.75,
    },
    {
      'stockName': 'TATAMOTORS',
      'amount': 2750.00,
    },
    {
      'stockName': 'HDFCBANK',
      'amount': 4125.30,
    },
  ];

  // Method to update selected stocks (will be passed to child widgets)
  void updateSelectedStock(String stockName, bool isSelected, double amount) {
    setState(() {
      selectedStocks[stockName] = isSelected;

      // Recalculate total amount using the correct amounts for each selected stock
      totalSelectedAmount = 0.0;
      selectedStocks.forEach((stock, selected) {
        if (selected) {
          // Find the correct stock in _allPledgeItems by name
          final stockData = _allPledgeItems.firstWhere(
            (item) => item['stockName'] == stock,
          );
          if (stockData != null) {
            totalSelectedAmount += (stockData['amount'] as double);
          }
        }
      });
      formattedAmount = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: 2,
      ).format(totalSelectedAmount);
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: options.length, vsync: this);
    tabController.addListener(() {
      setState(() {}); // Rebuild UI when a tab is selected
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
              "Pledge",
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.h),
            child: Column(
              children: [
                Divider(
                  height: 1,
                  color: isDark
                      ? const Color(0xff2F2F2F)
                      : const Color(0xffD1D5DB),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            // Tab bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomTabBar(
                tabController: tabController,
                options: options,
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // Pledge Tab
                  PledgeContentContent(
                      updateSelectedStock: updateSelectedStock),
                  // Unpledge Tab
                  unPledgedStocks(),
                  // History Tab
                  PledgeHistory(),
                ],
              ),
            ),
          ],
        ),
        // Bottom bar with continue button that appears when stocks are selected
        bottomNavigationBar: selectedStocks.entries
                .where((entry) => entry.value)
                .isEmpty
            ? null
            : Container(
                height: 100.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: const Color(0xFF2F2F2F),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Selected amount and count
                          Text(
                            '(${selectedStocks.entries.where((entry) => entry.value).length} selected)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${formattedAmount} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Continue button
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.w, left: 16.w, right: 16.w),
                      child: constWidgets.greenButton(
                        "Continue",
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.black,
                            builder: (sheetContext) {
                              Future.delayed(Duration(seconds: 2), () {
                                if (Navigator.of(sheetContext).canPop()) {
                                  Navigator.of(sheetContext).pop();
                                  // After closing modal, switch to History tab
                                  Future.microtask(() {
                                    if (mounted) tabController.index = 2;
                                  });
                                }
                              });
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                decoration: BoxDecoration(
                                  color:
                                      isDark ? Color(0xff121413) : Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 35.h),
                                    SvgPicture.asset(
                                      "assets/svgs/doneMark.svg",
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "Pledge request placed",
                                      style: TextStyle(
                                        fontSize: 21.sp,
                                        color: Color(0xFFEBEEF5),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      "Your pledge request has been successfully recorded and is currently being processed. This may take a few minutes to complete.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // Bottom sheet title
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

// Unpledge Content Widget
class UnpledgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Unpledge Content', style: TextStyle(color: Colors.white)));
  }
}
