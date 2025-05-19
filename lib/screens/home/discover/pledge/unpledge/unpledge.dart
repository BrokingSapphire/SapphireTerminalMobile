// Pledge Content Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class unPledgedStocks extends StatefulWidget {
  final Function(String, bool, double)? updateSelectedStock;

  const unPledgedStocks({Key? key, this.updateSelectedStock}) : super(key: key);

  @override
  State<unPledgedStocks> createState() => _unPledgedStocksState();
}

class _unPledgedStocksState extends State<unPledgedStocks> {
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
                      SizedBox(
                          height: 64.h,
                          width: 64.w,
                          child: SvgPicture.asset("assets/svgs/doneMark.svg")),
                      SizedBox(height: 20.h),
                      Text("No Pledgeable Holdings",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black)),
                      SizedBox(height: 10.h),
                      SizedBox(
                          width: 250.w,
                          child: Text(
                              "Your eligible holdings will appear here. Start investing to pledge!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.grey))),
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
