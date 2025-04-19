import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Orderbook extends StatefulWidget {
  const Orderbook({super.key});

  @override
  State<Orderbook> createState() => _OrderbookState();
}

class _OrderbookState extends State<Orderbook> {
  void showDownloadSheet(BuildContext context) {
    String? selectedSegment;
    String symbol = '';
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withOpacity(0.95),
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
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Divider(color: Color(0xff2F2F2F)),
                  SizedBox(height: 8.h),
                  Text("Segment"),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 50.h,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        hintText: 'Equity',
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      dropdownColor: Colors.grey.shade900,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      value: selectedSegment,
                      items: <String>['Equity', 'Futures', 'Options']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                  Text('Symbol'),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        hintText: 'e.g., NIFTY',
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      onChanged: (value) {
                        setState(() {
                          symbol = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text('Date range'),
                  SizedBox(height: 2.h),
                  GestureDetector(
                    onTap: () async {
                      final pickedDateRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDateRange: dateRange,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                                surface: Colors.grey.shade900,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDateRange != null) {
                        setState(() {
                          dateRange = pickedDateRange;
                        });
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        dateRange == null
                            ? 'Select date range'
                            : '${DateFormat('dd-MM-yyyy').format(dateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(dateRange!.end)}',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  constWidgets.greenButton(
                    "Download",
                    onTap: (symbol.isNotEmpty && dateRange != null)
                        ? () {
                            print(
                                "Downloading data for Segment: $selectedSegment, Symbol: $symbol, Date Range: ${DateFormat('dd-MM-yyyy').format(dateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(dateRange!.end)}");
                            Navigator.pop(context);
                          }
                        : null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 32.w,
            backgroundColor: Colors.black,
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Orderbook',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            )),
        body: Column(
          children: [
            const Divider(color: Color(0xff2F2F2F)),
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
                                fontSize: 13.sp, color: Color(0xffc9cacc)),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "10 Feb 2025 - 17 Feb 2025",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDownloadSheet(context);
                        },
                        child: Icon(
                          size: 24.sp,
                          Icons.calendar_today_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: constWidgets.greenButton('Download')));
  }
}
