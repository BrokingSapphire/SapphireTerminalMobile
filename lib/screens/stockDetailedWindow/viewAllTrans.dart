import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class ViewAllTransactions extends StatefulWidget {
  const ViewAllTransactions({Key? key}) : super(key: key);

  @override
  State<ViewAllTransactions> createState() => _ViewAllTransactionsState();
}

class _ViewAllTransactionsState extends State<ViewAllTransactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabOptions = ['Short Term', 'Long Term'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTransactionItem(
      String date, String quantity, String investedPrice, String atp) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Invested Price: ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$investedPrice",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Quantity: ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$quantity",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "ATP: ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? Colors.white70 : Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "$atp",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSection(
      String month, List<Map<String, String>> transactions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            month,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true, // Ensure it doesn't scroll independently
          physics:
              const NeverScrollableScrollPhysics(), // Disable scrolling within ListView
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionItem(
              transaction['date']!,
              transaction['quantity']!,
              transaction['investedPrice']!,
              transaction['atp']!,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 12.h, // Space above and below the divider
              thickness: 1.h,
              color: isDark
                  ? Color(0xff2f2f2f)
                  : Colors.grey[300], // Theme-aware divider color
            );
          },
        ),
      ],
    );
  }

  Widget _buildShortTermTab() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Mock data for short term transactions
    final aprilTransactions = [
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '12 April 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
    ];

    final marchTransactions = [
      {
        'date': '26 March 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
      {
        'date': '16 March 2025',
        'quantity': '60 Shares',
        'investedPrice': '₹1,34,789.00',
        'atp': '₹134',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isDark ? Colors.white : Color(0xff6B7280),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Qty.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "P&L",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "-₹445.60",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Present value",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "₹1,34,789.00",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "XIRR",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? Color(0xffc9cacc)
                                    : Color(0xff6B7280),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "₹245.60",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
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
            SizedBox(height: 16.h),
            // April transactions
            _buildMonthSection("April 2025", aprilTransactions),
            SizedBox(height: 16.h),
            // March transactions
            _buildMonthSection("March 2025", marchTransactions),
          ],
        ),
      ),
    );
  }

  Widget _buildLongTermTab() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Text(
          "No long term transactions available",
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leadingWidth: 28,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "All Transaction",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        // Add divider between title and tab bar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(41.h),
          child: Column(
            children: [
              // Divider between AppBar title and tab bar
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: isDark ? Color(0xff2f2f2f) : Colors.grey[300],
                ),
              ),
              // SizedBox(height: 16.h),
              CustomTabBar(
                tabController: _tabController,
                options: tabOptions,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShortTermTab(),
          _buildLongTermTab(),
        ],
      ),
    );
  }
}
