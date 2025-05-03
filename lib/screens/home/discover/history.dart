
// // History Content Widget
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HistoryContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text('History Content', style: TextStyle(color: Colors.white)));
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
//   final Function(String, bool)? onCheckChanged;

//   const _PledgeListItem({
//     required this.checked,
//     required this.stockName,
//     required this.haircut,
//     required this.qty,
//     required this.totalQty,
//     required this.margin,
//     required this.amount,
//     this.avatarUrl,
//     this.onCheckChanged,
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
//                 Theme(
//                   data: Theme.of(context).copyWith(
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//                   ),
//                   child: Checkbox(
//                     value: checked,
//                     onChanged: (value) {
//                       setState(() {
//                         checked = value!;
//                       });

//                       // Notify parent about checkbox change
//                       if (widget.onCheckChanged != null) {
//                         widget.onCheckChanged!(widget.stockName, value!);
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(widget.stockName,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 15.sp)),
//                       SizedBox(height: 6.h),
//                       RichText(
//                         text: TextSpan(
//                           text: 'Haircut  ',
//                           style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 11.sp),
//                           children: [
//                             TextSpan(
//                               text: widget.haircut,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 11.sp),
//                             ),
//                           ],
//                         ),
//                       ),
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
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w500)),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2.r),
//                               border: Border.all(
//                                   width: 0.5, color: Color(0xff2f2f2f))),
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 8.w),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 6.w),
//                                   child: Text(widget.qty,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w500)),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 4.w, vertical: 2.h),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff2f2f2f),
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(2.r),
//                                       bottomRight: Radius.circular(2.r),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(right: 6.w),
//                                     child: Text('/ ${widget.totalQty}',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.w500)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 6.h),
//                     RichText(
//                       text: TextSpan(
//                         text: 'Margin  ',
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 11.sp),
//                         children: [
//                           TextSpan(
//                             text: widget.margin,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 11.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Divider(color: Color(0xff2f2f2f)),
//         ],
//       ),
//     );
//   }
// }
