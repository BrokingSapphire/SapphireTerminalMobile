import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Tradesandcharges extends StatefulWidget {
  const Tradesandcharges({super.key});

  @override
  State<Tradesandcharges> createState() => _TradesandchargesState();
}

class _TradesandchargesState extends State<Tradesandcharges> {
  // Map to track expanded state of months
  Map<String, bool> monthExpanded = {};

  // Map to track expanded state of dates inside each month
  Map<String, Map<String, bool>> dateExpanded = {};

  // Sample order data (Month -> Date -> Orders List)
  final Map<String, Map<String, List<Map<String, String>>>> ordersData = {
    "Feb-2025": {
      "14-Feb-2025": [
        {
          "name": "Crude Oil",
          "quantity": "10",
          "value": "₹18,923.83",
          "brokerage": "₹53.35",
          "charges": "₹112.20",
        }
      ],
      "15-Feb-2025": [
        {
          "name": "Gold",
          "quantity": "5",
          "value": "₹45,500.50",
          "brokerage": "₹75.00",
          "charges": "₹150.75",
        }
      ],
    }
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Trades & Charges",
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
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )),
        ),
      ),
      body: Column(
        children: [
          Divider(
              color: isDark
                  ? Color(0xff2F2F2F)
                  : Color(0xffD1D5DB)), // Full-width divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 11.h),

                /// **Charges Summary Container**
                Container(
                  decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),

                      /// **Brokerage**
                      _buildRow("Brokerage", "₹2.60", isDark),

                      /// **Exchange Charges**
                      _buildRow("Exchange Charges", "₹1.52", isDark),

                      /// **Total Charges Box**
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: isDark
                                  ? Color(0xff252525)
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Total Charges",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(width: 4.w),
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.yellow,
                                              size: 16.sp,
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "₹4.12",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                            color: Colors.green,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// **Order Count Text**
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0.w),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        isDark ? Colors.white : Colors.black),
                                children: [
                                  TextSpan(text: "You have placed "),
                                  TextSpan(
                                    text: "1",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                      text: " orders in the selected duration"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// **Trade Summary**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trade and Charges Summary for",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark ? Colors.white : Colors.black),
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
                    Icon(Icons.calendar_today_outlined, color: Colors.green),
                  ],
                ),

                SizedBox(height: 16.h),

                /// **Search Bar**
                constWidgets.searchField(
                    context, "Search company or stock", "positions", isDark),
                SizedBox(height: 10.h),
              ],
            ),
          ),

          /// **Expandable Order List**
          Expanded(child: orderTilesExpandables(isDark)),
        ],
      ),
    );
  }

  /// **Widget for Expandable Order List**
  Widget orderTilesExpandables(bool isDark) {
    return ListView(
      shrinkWrap: true, // Prevents infinite height issue
      children: ordersData.entries.map((monthEntry) {
        String month = monthEntry.key;
        Map<String, List<Map<String, String>>> dates = monthEntry.value;

        // Ensure month entry is initialized
        monthExpanded.putIfAbsent(month, () => false);

        return Column(
          children: [
            /// **Month Expandable Header**
            GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle month expansion
                  monthExpanded[month] = !monthExpanded[month]!;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          month,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 21.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.green),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.h),
                            child: Center(
                              child: Text(
                                "1 Orders",
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.green),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      monthExpanded[month]!
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            /// **Show Dates if Month is Expanded**
            if (monthExpanded[month]!)
              ...dates.entries.map((dateEntry) {
                String date = dateEntry.key;
                List<Map<String, String>> orders = dateEntry.value;

                // Ensure date entry is initialized inside the corresponding month
                if (!dateExpanded.containsKey(month)) {
                  dateExpanded[month] = {};
                }
                dateExpanded[month]!.putIfAbsent(date, () => false);

                return Column(
                  children: [
                    /// **Date Expandable Header**
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle date expansion
                          dateExpanded[month]![date] =
                              !dateExpanded[month]![date]!;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  height: 21.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7.h),
                                    child: Center(
                                      child: Text(
                                        "1 Orders",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.green),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              dateExpanded[month]![date]!
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// **Show Orders if Date is Expanded**
                    if (dateExpanded[month]![date]!)
                      ...orders.map((order) {
                        return _buildOrderDetails(order, isDark);
                      }),
                  ],
                );
              }).toList(),
          ],
        );
      }).toList(),
    );
  }

  /// **Order Details Container**
  Widget _buildOrderDetails(Map<String, String> order, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Color(0xff1B1B1B) : Color(0xffF4F4F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Title & DELIVERY Badge**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['name'] ?? '',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff333333) : Color(0xfff1f8f6),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  "DELIVERY",
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),

          /// **Folder Icon & Quantity + BUY Badge**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.folder_outlined, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text(
                    order['quantity'] ?? '',
                    style: TextStyle(fontSize: 14.sp, color: Colors.green),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff143520) : Color(0xfff1f8f6),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  "BUY",
                  style: TextStyle(fontSize: 10.sp, color: Colors.green),
                ),
              ),
            ],
          ),
          Divider(
              color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB),
              thickness: 0.5),

          /// **Order Details**
          _orderDetailRow("Order value", order['value'] ?? '', isDark),
          _orderDetailRow("Brokerage", order['brokerage'] ?? '', isDark),
          _orderDetailRow(
              "Charges", order['charges'] ?? '', isDark, Colors.red),
        ],
      ),
    );
  }

  /// **Reusable Row for Charges**
  Widget _orderDetailRow(String label, String value, bool isDark,
      [Color? color]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? Colors.white70 : Colors.black)),
          Text(
            value,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: color ?? (isDark ? Colors.white : Colors.black)),
          ),
        ],
      ),
    );
  }

  /// **Reusable Row for Charges**
  Widget _buildRow(String label, String value, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 5.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black)),
        Text(value,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black)),
      ]),
    );
  }
}
