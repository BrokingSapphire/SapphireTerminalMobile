import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/stockDetailedWindow/viewAllTrans.dart';

class MutualFundsDetails extends StatefulWidget {
  const MutualFundsDetails({Key? key}) : super(key: key);

  @override
  State<MutualFundsDetails> createState() => _MutualFundsDetailsState();
}

class _MutualFundsDetailsState extends State<MutualFundsDetails> {
  // Add a focus node to track when search field is focused
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen for focus changes to show/hide bottom bar
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Trigger rebuild when focus changes
    setState(() {});
  }

  Widget _buildInfoRow(String label, String value,
      {bool isGreen = false, bool alignRight = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Color(0xffc9cacc) : Color(0xff6B7280),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color:
                isGreen ? Colors.green : (isDark ? Colors.white : Colors.black),
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
      ],
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
          "My Investment",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 1.h,
            color: Color(0xff2f2f2f),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Fund Name Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Motilal Oswal Midcap Fund Direct Growth",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Regular · Equity-Midcap",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isDark
                                        ? Color(0xffc9cacc)
                                        : Color(0xff6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h), // Gap between sections

                    // P&L Section
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
                            "P&L",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark
                                  ? Color(0xffc9cacc)
                                  : Color(0xff6B7280),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                "+₹22,678.80",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "(2.78%)",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
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
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
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
                                      "0.00%",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
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
                                      "Current value",
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
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
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
                    SizedBox(height: 16.h), // Gap between sections

                    // NAV Details Section
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Avg Nav",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                              Text(
                                "Units",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                              Text(
                                "Current Nav",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "1500/1500",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                "327.00",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                "₹1,34,789.00",
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
                    ),
                    SizedBox(height: 16.h), // Gap between sections

                    // Mutual Fund Details Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xff121413) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          // Header with title and view all link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mutual Funds Details",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  navi(ViewAllTransactions(), context);
                                },
                                child: Text(
                                  "View all Transactions",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xff1DB954),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Position Rows - Redesigned to match the image
                          Row(
                            children: [
                              // Short term container
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff121212)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isDark
                                          ? Color(0xff2F2F2F)
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Short term",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff252525)
                                              : Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: isDark
                                                ? Color(0xff2F2F2F)
                                                : Colors.grey[300]!,
                                            width: 1,
                                          ),
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
                                                  "Qty.",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "1000",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "-₹12,347.00",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Long term container
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Color(0xff121212)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isDark
                                          ? Color(0xff2F2F2F)
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Long term",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff252525)
                                              : Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: isDark
                                                ? Color(0xff2F2F2F)
                                                : Colors.grey[300]!,
                                            width: 1,
                                          ),
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
                                                  "Qty.",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Value",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: isDark
                                                        ? Color(0xffC9CACC)
                                                        : Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "+₹12,347.00",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Folio No.: 856846",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom * 0,
        ),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle EXIT action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "EXIT",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle ADD action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1DB954),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
