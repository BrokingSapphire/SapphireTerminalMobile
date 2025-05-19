import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Choosestocktogift extends StatefulWidget {
  const Choosestocktogift({super.key});

  @override
  State<Choosestocktogift> createState() => _ChoosestocktogiftState();
}

class _ChoosestocktogiftState extends State<Choosestocktogift>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final options = ['Pledge'];
  List<String> stocks = [];
  bool checked = false;

  int _selectedIndex = 0;
  bool _canResendOtp = false;
  int _remainingSeconds = 2;

  // Track selected stocks and total amount across tabs
  Map<String, bool> selectedStocks = {};
  double totalSelectedAmount = 0.0;
  String formattedAmount = "";
  void _startResendTimer(StateSetter setModalState) {
    _canResendOtp = false;
    _remainingSeconds = 2;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setModalState(() {
          _remainingSeconds--;
        });
      } else {
        setModalState(() {
          _canResendOtp = true;
        });
        timer.cancel();
      }
    });
  }

  void showSuccessPopup(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                "Gift sent succesfully!",
                style: TextStyle(
                  fontSize: 21.sp,
                  color: Color(0xFFEBEEF5),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Invest in stocks and track your portfolio here.",
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
  }

  // Method to show the forget MPIN bottom sheet with OTP fields
  void showOtpPopup(BuildContext context, bool isDark) {
    // Reset timer state and OTP field
    _canResendOtp = false;
    _remainingSeconds = 2;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xff121413),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          // Start the timer when the modal is first shown
          if (_remainingSeconds == 2) {
            _startResendTimer(setModalState);
          }

          return Padding(
            // Add padding to account for keyboard
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // Use constraints instead of fixed height to allow content to adjust with keyboard
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                minHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Color(0xff121413),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Info text
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18.sp,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'OTP has been sent to your registered phone number',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Phone OTP section
                      Text(
                        'Enter 6-digit OTP',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 48.w,
                          height: 48.h,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? Color(0xff2F2F2F)
                                  : Color(0xffD1D5DB),
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 40.w,
                          height: 40.h,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF1DB954),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Resend OTP with timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive OTP? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          _canResendOtp
                              ? InkWell(
                                  onTap: () {
                                    // Resend OTP logic
                                    constWidgets.snackbar(
                                        "OTP resent successfully",
                                        Colors.green,
                                        context);
                                    // Restart timer
                                    _startResendTimer(setModalState);
                                  },
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: Color(0xFF1DB954),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend in ${_remainingSeconds}s',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Verify button
                      Container(
                        height: 48.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          // onPressed: _phoneOtpController.text.length == 6
                          //     ? () {
                          //         // Close bottom sheet and navigate to change new PIN screen
                          //         Navigator.pop(context);
                          //         navi(changeNewPinScreen(), context);
                          //       }
                          //     : null,
                          onPressed: () {
                            Navigator.pop(context);
                            showSuccessPopup(context, isDark);
                          },
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1DB954),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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
          backgroundColor: isDark ? Colors.black : Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 32.w,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Choose Stocks to Gift",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
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
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(
              height: 1.h,
              color: const Color(0xFF2F2F2F),
            ),
            // Tab bar

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // Pledge Tab
                  PledgeContent(updateSelectedStock: updateSelectedStock),
                ],
              ),
            ),
          ],
        ),
        // Bottom bar with continue button that appears when stocks are selected
        bottomNavigationBar:
            selectedStocks.entries.where((entry) => entry.value).isEmpty
                ? null
                : Container(
                    height: 110.h,
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
                        SizedBox(height: 16.h),
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
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${formattedAmount} ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
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
                              showOtpPopup(context, isDark);
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

// Pledge Content Widget
class PledgeContent extends StatefulWidget {
  final Function(String, bool, double)? updateSelectedStock;

  const PledgeContent({Key? key, this.updateSelectedStock}) : super(key: key);

  @override
  State<PledgeContent> createState() => _PledgeContentState();
}

class _PledgeContentState extends State<PledgeContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Track selected stocks locally
  Map<String, bool> _selectedStocks = {};

  // List of all pledge items with amount as double for calculations
  final List<Map<String, dynamic>> _pledgeItems = [
    {
      'stockName': 'BAJAJ-AUTO',
      'haircut': '11.41%',
      'qty': '100',
      'totalQty': '100',
      'margin': '₹1,995.55',
      'amount': 1995.55,
    },
    {
      'stockName': 'GMRAIRPORT',
      'haircut': '11.41%',
      'qty': '1397',
      'totalQty': '1397',
      'margin': '₹1,995.55',
      'amount': 1995.55,
    },
    {
      'stockName': 'RELIANCE',
      'haircut': '10.25%',
      'qty': '200',
      'totalQty': '200',
      'margin': '₹3,450.75',
      'amount': 3450.75,
    },
    {
      'stockName': 'TATAMOTORS',
      'haircut': '12.50%',
      'qty': '500',
      'totalQty': '500',
      'margin': '₹2,750.00',
      'amount': 2750.00,
    },
    {
      'stockName': 'HDFCBANK',
      'haircut': '9.75%',
      'qty': '150',
      'totalQty': '150',
      'margin': '₹4,125.30',
      'amount': 4125.30,
    },
  ];

  // Filtered list based on search query
  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) {
      return _pledgeItems;
    }

    final query = _searchQuery.toLowerCase();
    return _pledgeItems.where((item) {
      return item['stockName'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: constWidgets.searchFieldWithInput(
              showFilter: false,
              context,
              "Search by name or ticker",
              "equity",
              isDark,
              controller: _searchController, onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          }),
        ),
        SizedBox(height: 11.h),
        Expanded(
          child: _filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      Icon(
                        Icons.search_off,
                        size: 48.sp,
                        color: isDark ? Colors.grey : Colors.grey.shade600,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _searchQuery.isEmpty
                            ? "No Equity Investments"
                            : "No stocks starting with '${_searchQuery}' found",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          _searchQuery.isEmpty
                              ? "Invest in stocks to build your equity portfolio."
                              : "Try a different search term",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = _filteredItems[index];
                    // Get the checked state from local tracking
                    bool isChecked =
                        _selectedStocks[item['stockName'].toString()] ?? false;
                    return _PledgeListItem(
                      checked: isChecked,
                      stockName: item['stockName'].toString(),
                      haircut: item['haircut'].toString(),
                      qty: item['qty'].toString(),
                      totalQty: item['totalQty'].toString(),
                      margin: item['margin'].toString(),
                      amount: item['amount'] as double,
                      avatarUrl: null, // Replace with actual image if needed
                      onCheckChanged: (stockName, isChecked) {
                        setState(() {
                          _selectedStocks[stockName] = isChecked;
                        });

                        // Notify parent about the change
                        if (widget.updateSelectedStock != null) {
                          widget.updateSelectedStock!(
                              stockName, isChecked, item['amount'] as double);
                        }
                      },
                    );
                  },
                ),
        ),
      ],
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

// History Content Widget
class HistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('History Content', style: TextStyle(color: Colors.white)));
  }
}

class _PledgeListItem extends StatefulWidget {
  final bool checked;
  final String stockName;
  final String haircut;
  final String qty;
  final String totalQty;
  final String margin;
  final double amount;
  final String? avatarUrl;
  final Function(String, bool)? onCheckChanged;

  const _PledgeListItem({
    required this.checked,
    required this.stockName,
    required this.haircut,
    required this.qty,
    required this.totalQty,
    required this.margin,
    required this.amount,
    this.avatarUrl,
    this.onCheckChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<_PledgeListItem> createState() => _PledgeListItemState();
}

class _PledgeListItemState extends State<_PledgeListItem> {
  late bool checked;
  late TextEditingController qtyController;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
    qtyController = TextEditingController(text: widget.qty);
  }

  @override
  void dispose() {
    qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked; // Toggle the checkbox
        });

        // Notify parent about checkbox change
        if (widget.onCheckChanged != null) {
          widget.onCheckChanged!(widget.stockName, checked);
        }
        print('Tapped on ${widget.stockName}');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  child: Checkbox(
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        checked = value!;
                      });

                      // Notify parent about checkbox change
                      if (widget.onCheckChanged != null) {
                        widget.onCheckChanged!(widget.stockName, value!);
                      }
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.stockName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp)),
                      SizedBox(height: 6.h),
                      RichText(
                        text: TextSpan(
                          text: 'Tata Motors  ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp),
                          children: [
                            TextSpan(
                              text: widget.haircut,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text('Qty : ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500)),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              border: Border.all(
                                  width: 0.5, color: Color(0xff2f2f2f))),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 6.w),
                                  child: SizedBox(
                                    width: 30.w,
                                    height: 25.h,
                                    child: TextField(
                                      controller: qtyController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense:
                                            true, // Minimizes vertical height
                                        contentPadding: EdgeInsets.only(
                                            top: 4
                                                .h), // Removes internal padding
                                        border:
                                            InputBorder.none, // Removes borders
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        int? enteredQty = int.tryParse(value);
                                        int totalQty =
                                            int.parse(widget.totalQty);
                                        if (enteredQty != null &&
                                            enteredQty > totalQty) {
                                          // If entered quantity exceeds total quantity, reset to totalQty
                                          setState(() {
                                            qtyController.text =
                                                widget.totalQty;
                                          });
                                        }
                                        // Here you would update the qty value, potentially notifying parent
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xff2f2f2f),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(2.r),
                                      bottomRight: Radius.circular(2.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 6.w, top: 5.h),
                                    child: Text('/ ${widget.totalQty}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    RichText(
                      text: TextSpan(
                        text: 'Invested Value  ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp),
                        children: [
                          TextSpan(
                            text: widget.margin,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Color(0xff2f2f2f)),
        ],
      ),
    );
  }
}
