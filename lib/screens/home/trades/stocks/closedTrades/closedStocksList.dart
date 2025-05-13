import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClosedListScreen extends StatefulWidget {
  final List<Map<String, String>>? filteredStocks; // Optional parameter

  const ClosedListScreen({super.key, this.filteredStocks});

  @override
  State<ClosedListScreen> createState() => _ClosedListScreenState();
}

class _ClosedListScreenState extends State<ClosedListScreen> {
  // Default stock data maintained within the class
  late List<Map<String, String>> _stocks;

  @override
  void initState() {
    super.initState();
    // Initialize _stocks with default data if widget.filteredStocks is null
    _stocks = widget.filteredStocks ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: _stocks.map((stock) => buildStockCard(stock)).toList(),
        ),
      ),
    );
  }

  Widget buildStockCard(Map<String, String> stock) {
    final isBuy = stock["action"] == "BUY";
    final symbol = stock["symbol"] ?? "UNKNOWN";
    final logoPath =
        'assets/images/${stock["logo"] ?? "${symbol.toLowerCase()} logo.png"}';

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xff121413),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Logo + Title + Action + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Symbol + Company Name
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14.r,
                        child: ClipOval(
                          child: Image.asset(
                            logoPath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Text(
                                symbol[0],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                symbol,
                                style: TextStyle(
                                    color: const Color(0xffEBEEF5),
                                    fontSize: 13.sp),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: isBuy
                                      ? const Color(0xff143520)
                                      : const Color(0xff351414),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  stock["action"] ?? "BUY",
                                  style: TextStyle(
                                    color: isBuy
                                        ? const Color(0xff22a06b)
                                        : const Color(0xffFF5252),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            stock["companyName"] ?? "Unknown Company",
                            style: TextStyle(
                                color: const Color(0xffEBEEF5),
                                fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Status",
                          style: TextStyle(
                              color: const Color(0xffEBEEF5), fontSize: 13.sp)),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xff69686230),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Target Miss',
                          style: TextStyle(
                              color: const Color(0xffFFD761), fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              tradeDetailRow('Entry', '₹1,580.60', '14 Feb 2025 |', ' 8:32 pm'),
              SizedBox(height: 12.h),
              tradeDetailRow(
                  'Exit   ', '₹1,752.12', '15 Feb 2025 |', ' 9:32 pm'),
              SizedBox(height: 12.h),
              // Net Gain
              Container(
                height: 28.h,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                  color: const Color(0xff58585850),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Net gain:',
                      style: TextStyle(
                          color: const Color(0xffEBEEF5), fontSize: 12.sp),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '+6.08%',
                      style: TextStyle(
                          color: const Color(0xff1DB954),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // About Trade Button
              SizedBox(
                height: 34.h,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff2F2F2F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text(
                    'About Trade',
                    style: TextStyle(
                      color: Color(0xffEBEEF5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget tradeDetailRow(String title, String value, String date, String time) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Color(0xffc9cacc), fontSize: 13.sp),
        ),
        SizedBox(width: 46.w),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        Spacer(),
        Text(
          date,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        Text(
          time,
          style: TextStyle(color: Color(0xff9B9B9B), fontSize: 12.sp),
        ),
      ],
    );
  }
}