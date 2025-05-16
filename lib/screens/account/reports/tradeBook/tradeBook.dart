import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sapphire/screens/account/reports/customCalender.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Tradebook extends StatefulWidget {
  const Tradebook({super.key});

  @override
  State<Tradebook> createState() => _TradebookState();
}

class _TradebookState extends State<Tradebook> {
  void showDownloadSheet(BuildContext context) {
    String? selectedSegment = 'Equity'; // Default selected value
    DateTimeRange? dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade900.withOpacity(0.95)
                    : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Search and filter",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 4.h),
                  Divider(
                      color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
                  SizedBox(height: 8.h),
                  Text("Segment",
                      softWrap: true,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 40.h,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        hintText: 'Equity',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 10.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w), // Remove default padding
                      ),
                      dropdownColor:
                          isDark ? Colors.grey.shade800 : Color(0xffF4F4F9),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      value: selectedSegment,
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Equity', 'Futures', 'Options']
                            .map<Widget>(
                          (String value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp,
                                ),
                                softWrap: true,
                              ),
                            );
                          },
                        ).toList();
                      },
                      items: <String>['Equity', 'Futures', 'Options']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 13.sp),
                            softWrap: true,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSegment = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Symbol',
                    softWrap: true,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 13.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        hintText: 'e.g., NIFTY',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Date range',
                    softWrap: true,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  GestureDetector(
                    onTap: () async {
                      _showCustomDateRangePicker();
                    },
                    child: Container(
                      height: 40.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${DateFormat('dd-MM-yyyy').format(dateRange.start)} - ${DateFormat('dd-MM-yyyy').format(dateRange.end)}',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 13.sp,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  constWidgets.greenButton("Download", onTap: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  DateTimeRange? _selectedDateRange;

  Future<void> _showCustomDateRangePicker() async {
    final DateTimeRange? picked = await showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => CustomDateRangePickerBottomSheet(
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDateRange: _selectedDateRange,
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 32.w,
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Tradebook',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
            softWrap: true,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
            height: 1.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Statement for",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isDark ? Color(0xffc9cacc) : Colors.black,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "10 Feb 2025 - 17 Feb 2025",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showDownloadSheet(context);
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/calender.svg',
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff2f2f2f),
                  thickness: 1,
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: constWidgets.greenButton('Download'),
      ),
    );
  }
}
