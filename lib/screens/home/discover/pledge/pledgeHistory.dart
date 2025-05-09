// History Content Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PledgeHistory extends StatelessWidget {
  const PledgeHistory({super.key});

  Widget _buildHistoryItem(
      {required String date,
      required String status,
      required List<Map<String, dynamic>> stocks}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and status row
          Padding(
            padding: EdgeInsets.only(
                right: 16.w, left: 16.w, top: 16.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xffEBEEF5),
                    fontSize: 11.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              height: 1,
              color: const Color(0xff2F2F2F),
            ),
          ),
          // Stock items
          ...stocks.map((stock) => _buildStockItem(
                stockName: stock['name'],
                quantity: stock['quantity'],
                marginApproved: stock['marginApproved'],
              )),
        ],
      ),
    );
  }

  // Helper method to get the appropriate color based on status
  Color _getStatusColor(String status) {
    if (status.contains('Pending')) {
      return const Color(0xFFFFD700); // Yellow for pending
    } else if (status.contains('Completed')) {
      return Colors.green; // Green for completed
    } else if (status.contains('Rejected')) {
      return Colors.red; // Red for rejected
    }
    return Colors.green; // Default color
  }

  Widget _buildStockItem({
    required String stockName,
    required int quantity,
    required num marginApproved,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
      child: Row(
        children: [
          // Stock icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xff1E1E1E),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.business,
                color: Colors.green,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Stock details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stockName,
                  style: TextStyle(
                    color: const Color(0xffEBEEF5),
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Quantity : $quantity',
                  style: TextStyle(
                    color: const Color(0xffC9CACC),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          // Margin approved
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Margin Approved (₹)',
                style: TextStyle(
                  color: const Color(0xffC9CACC),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '₹${marginApproved.toStringAsFixed(0)}',
                style: TextStyle(
                  color: const Color(0xffEBEEF5),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sample data for demonstration
    final List<Map<String, dynamic>> historyItems = [
      {
        'date': '16 April 2025, 03:12 PM',
        'status': 'Pledge Request Pending',
        'stocks': [
          {
            'name': 'BAJFINANCE',
            'quantity': 60,
            'marginApproved': 1053532,
          },
          {
            'name': 'IREDA',
            'quantity': 60,
            'marginApproved': 53532,
          },
          {
            'name': 'HDFCBANK',
            'quantity': 60,
            'marginApproved': 853532,
          },
        ],
      },
      {
        'date': '16 April 2025, 03:12 PM',
        'status': 'Pledge Request Completed',
        'stocks': [
          {
            'name': 'BAJFINANCE',
            'quantity': 60,
            'marginApproved': 1053532,
          },
          {
            'name': 'IREDA',
            'quantity': 60,
            'marginApproved': 53532,
          },
          {
            'name': 'HDFCBANK',
            'quantity': 60,
            'marginApproved': 853532,
          },
        ],
      },
      {
        'date': '16 April 2025, 03:12 PM',
        'status': 'Pledge Request Rejected',
        'stocks': [
          {
            'name': 'BAJFINANCE',
            'quantity': 60,
            'marginApproved': 1053532,
          },
          {
            'name': 'IREDA',
            'quantity': 60,
            'marginApproved': 53532,
          },
          {
            'name': 'HDFCBANK',
            'quantity': 60,
            'marginApproved': 853532,
          },
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "History for",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "10 Feb 2025 - 17 Feb 2025",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(
                  size: 24.sp,
                  Icons.calendar_today_outlined,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              height: 1,
              color: const Color(0xFF2F2F2F),
            ),
            SizedBox(height: 16.h),
            Text(
              "April 2025",
              style: TextStyle(
                color: const Color(0xffEBEEF5),
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return _buildHistoryItem(
                    date: item['date'],
                    status: item['status'],
                    stocks: item['stocks'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
