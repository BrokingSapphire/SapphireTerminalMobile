import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

  String _selectedOrderType = "Buy";
  int _selectedIndex = 0;
  late PageController _pageController;

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
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Instant switch for taps
    });
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
            SizedBox(height: 12.h),
            // Tab bar
            CustomTabBar(
              tabController: tabController,
              options: options,
            ),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // Pledge Tab
                  PledgeContent(updateSelectedStock: updateSelectedStock),
                  // Unpledge Tab
                  UnpledgeContent(),
                  // History Tab
                  HistoryContent(),
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
                          text: 'Haircut  ',
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
                                    padding: EdgeInsets.only(right: 6.w,top: 5.h),
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
                        text: 'Margin  ',
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
