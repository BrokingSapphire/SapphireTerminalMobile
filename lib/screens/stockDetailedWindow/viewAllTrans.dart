import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewAllTransactions extends StatefulWidget {
  const ViewAllTransactions({Key? key}) : super(key: key);

  @override
  State<ViewAllTransactions> createState() => _ViewAllTransactionsState();
}

class _ViewAllTransactionsState extends State<ViewAllTransactions> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
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

  Widget _buildTransactionItem(String date, String quantity, String investedPrice, String atp) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
              Text(
                "Invested Price: $investedPrice",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity : $quantity",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                ),
              ),
              Text(
                "ATP : $atp",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSection(String month, List<Map<String, String>> transactions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            month,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        ...transactions.map((transaction) => _buildTransactionItem(
              transaction['date']!,
              transaction['quantity']!,
              transaction['investedPrice']!,
              transaction['atp']!,
            )),
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Qty.",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "100",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "P&L",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Present value",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "₹1,34,789.00",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "XIRR",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.green,
              unselectedLabelColor: isDark ? Colors.white : Colors.black,
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: "Short Term"),
                Tab(text: "Long Term"),
              ],
            ),
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