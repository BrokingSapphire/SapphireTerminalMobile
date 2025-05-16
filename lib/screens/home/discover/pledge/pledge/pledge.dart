import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:sapphire/screens/home/discover/pledge/history/pledgeHistory.dart';
import 'package:sapphire/screens/home/discover/pledge/pledgeStocks.dart';
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

  // Method to update selected stocks (will be passed to child widgets)
  void updateSelectedStock(String stockName, bool isSelected, double amount) {
    setState(() {
      selectedStocks[stockName] = isSelected;

      // Recalculate total amount
      totalSelectedAmount = 0.0;
      selectedStocks.forEach((stock, selected) {
        formattedAmount = NumberFormat.currency(
          locale: 'en_IN',
          symbol: '₹',
          decimalDigits: 2,
        ).format(totalSelectedAmount);

        if (selected) {
          // Find the stock in the data and add its amount
          // This is a placeholder - actual implementation would use real data
          totalSelectedAmount += amount;
        }
      });
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
          leadingWidth: 38.w,
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Pledge",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(
              height: 1,
              color: const Color(0xFF2F2F2F),
            ),
            SizedBox(height: 16.h),
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
                  UnpledgeContent(),
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
                height: 90.h,
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
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: constWidgets.greenButton(
                        "Continue",
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.black,
                            builder: (context) {
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
