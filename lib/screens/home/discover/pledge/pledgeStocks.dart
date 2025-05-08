// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sapphire/utils/constWidgets.dart';

// class PledgeContent extends StatefulWidget {
//   final Function(String, bool, double)? updateSelectedStock;

//   const PledgeContent({Key? key, this.updateSelectedStock}) : super(key: key);

//   @override
//   State<PledgeContent> createState() => _PledgeContentState();
// }

// class _PledgeContentState extends State<PledgeContent> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   // Track selected stocks locally
//   Map<String, bool> _selectedStocks = {};

//   // List of all pledge items with amount as double for calculations
//   final List<Map<String, dynamic>> _pledgeItems = [
//     {
//       'stockName': 'BAJAJ-AUTO',
//       'haircut': '11.41%',
//       'qty': '100',
//       'totalQty': '100',
//       'margin': '₹1,995.55',
//       'amount': 1995.55,
//     },
//     {
//       'stockName': 'GMRAIRPORT',
//       'haircut': '11.41%',
//       'qty': '1397',
//       'totalQty': '1397',
//       'margin': '₹1,995.55',
//       'amount': 1995.55,
//     },
//     {
//       'stockName': 'RELIANCE',
//       'haircut': '10.25%',
//       'qty': '200',
//       'totalQty': '200',
//       'margin': '₹3,450.75',
//       'amount': 3450.75,
//     },
//     {
//       'stockName': 'TATAMOTORS',
//       'haircut': '12.50%',
//       'qty': '500',
//       'totalQty': '500',
//       'margin': '₹2,750.00',
//       'amount': 2750.00,
//     },
//     {
//       'stockName': 'HDFCBANK',
//       'haircut': '9.75%',
//       'qty': '150',
//       'totalQty': '150',
//       'margin': '₹4,125.30',
//       'amount': 4125.30,
//     },
//   ];

//   // Filtered list based on search query
//   List<Map<String, dynamic>> get _filteredItems {
//     if (_searchQuery.isEmpty) {
//       return _pledgeItems;
//     }

//     final query = _searchQuery.toLowerCase();
//     return _pledgeItems.where((item) {
//       return item['stockName'].toString().toLowerCase().contains(query);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Column(
//       children: [
//         SizedBox(
//           height: 16.h,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: constWidgets.searchFieldWithInput(
//               showFilter: false,
//               context,
//               "Search by name or ticker",
//               "equity",
//               isDark,
//               controller: _searchController, onChanged: (value) {
//             setState(() {
//               _searchQuery = value;
//             });
//           }),
//         ),
//         SizedBox(height: 16.h),
//         Expanded(
//           child: _filteredItems.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 50.h),
//                       Icon(
//                         Icons.search_off,
//                         size: 48.sp,
//                         color: isDark ? Colors.grey : Colors.grey.shade600,
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         _searchQuery.isEmpty
//                             ? "No Equity Investments"
//                             : "No stocks starting with '${_searchQuery}' found",
//                         style: TextStyle(
//                             fontSize: 18.sp, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8.h),
//                       SizedBox(
//                         width: 250.w,
//                         child: Text(
//                           _searchQuery.isEmpty
//                               ? "Invest in stocks to build your equity portfolio."
//                               : "Try a different search term",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 16.sp, color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(height: 50.h),
//                     ],
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: _filteredItems.length,
//                   itemBuilder: (context, index) {
//                     final item = _filteredItems[index];
//                     // Get the checked state from local tracking
//                     bool isChecked =
//                         _selectedStocks[item['stockName'].toString()] ?? false;
//                     return _PledgeListItem(
//                       checked: isChecked,
//                       stockName: item['stockName'].toString(),
//                       haircut: item['haircut'].toString(),
//                       qty: item['qty'].toString(),
//                       totalQty: item['totalQty'].toString(),
//                       margin: item['margin'].toString(),
//                       amount: item['amount'] as double,
//                       avatarUrl: null, // Replace with actual image if needed
//                       onCheckChanged: (stockName, isChecked, amount) {
//                         setState(() {
//                           _selectedStocks[stockName] = isChecked;
//                         });

//                         // Notify parent about the change
//                         if (widget.updateSelectedStock != null) {
//                           widget.updateSelectedStock!(
//                               stockName, isChecked, amount);
//                         }
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

// class _PledgeListItem extends StatefulWidget {
//   final bool checked;
//   final String stockName;
//   final String haircut;
//   final String qty;
//   final String totalQty;
//   final String margin;
//   final double amount;
//   final String? avatarUrl;
//   final Function(String, bool, double) onCheckChanged;

//   const _PledgeListItem({
//     required this.checked,
//     required this.stockName,
//     required this.haircut,
//     required this.qty,
//     required this.totalQty,
//     required this.margin,
//     required this.amount,
//     required this.onCheckChanged,
//     this.avatarUrl,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<_PledgeListItem> createState() => _PledgeListItemState();
// }

// class _PledgeListItemState extends State<_PledgeListItem> {
//   late bool checked;

//   @override
//   void initState() {
//     super.initState();
//     checked = widget.checked;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           checked = !checked; // Toggle the checkbox
//         });
//         print('Tapped on ${widget.stockName}');
//       },
//       behavior: HitTestBehavior.opaque,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//             child: Row(
//               children: [
//                 // Custom checkbox design instead of the default one
//                 CustomCheckbox(
//                     size: 18.sp,
//                     value: checked,
//                     onChanged: (value) {
//                       setState(() {
//                         checked = value!;
//                       });
//                       widget.onCheckChanged(widget.stockName, value!, widget.amount);
//                     }),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(widget.stockName,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 15.sp)),
//                           SizedBox(width: 8),
//                           if (widget.avatarUrl != null)
//                             CircleAvatar(
//                               radius: 14,
//                               backgroundImage: NetworkImage(widget.avatarUrl!),
//                             )
//                           else
//                             CircleAvatar(
//                               radius: 14.r,
//                               backgroundColor: Colors.grey.shade800,
//                               child: Icon(Icons.person,
//                                   color: Colors.white, size: 18.sp),
//                             ),
//                         ],
//                       ),
//                       SizedBox(height: 4.h),
//                       Text('Haircut  ${widget.haircut}',
//                           style: TextStyle(color: Colors.grey, fontSize: 13)),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         Text('Qty : ',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13.sp,
//                                 fontWeight: FontWeight.w500)),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 7.w, vertical: 2.h),
//                           decoration: BoxDecoration(
//                             color: Color(0xff23262B),
//                             borderRadius: BorderRadius.circular(6.r),
//                           ),
//                           child: Text('${widget.qty} / ${widget.totalQty}',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13.sp,
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Text('Margin ${widget.margin}',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.sp)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }
// }
