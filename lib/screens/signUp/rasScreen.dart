// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sapphire/main.dart';
// import 'package:sapphire/screens/signUp/linkBankScreen.dart';

// import '../../utils/constWidgets.dart';

// class rasScreen extends StatefulWidget {
//   const rasScreen({super.key});

//   @override
//   State<rasScreen> createState() => _rasScreenState();
// }

// class _rasScreenState extends State<rasScreen> {
//   double width = 0;

//   String? selectedSettlement;
//   String? selectedPEP;

//   /// ✅ Function to check if all required selections are made
//   bool get isFormComplete => selectedSettlement != null && selectedPEP != null;

//   /// ✅ Updates selected option and refreshes UI
//   void _selectOption(String category, String value) {
//     setState(() {
//       if (category == "Settlement") {
//         selectedSettlement = value;
//       } else if (category == "PEP") {
//         selectedPEP = value;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width / 2 - 20;

//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 46,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 0),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 8.h),
//             constWidgets.topProgressBar(1, 4, context),
//             SizedBox(height: 24.h),
//             Text(
//               "Set Your Account Preferences",
//               style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 16.h),

//             /// ✅ RUNNING ACCOUNT SETTLEMENT SELECTION
//             Text(
//               "Preference for running account settlement",
//               style: TextStyle(fontSize: 17.sp, color: Color(0xffEBEEF5)),
//             ),
//             SizedBox(height: 12.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildSelectableChip("Settlement", "Quarterly", 106.w),
//                 SizedBox(width: 20.w),
//                 _buildSelectableChip("Settlement", "Monthly", 106.w),
//               ],
//             ),
//             SizedBox(height: 18.h),

//             /// ✅ POLITICALLY EXPOSED PERSON (PEP) SELECTION
//             Text(
//               "Are you a Politically Exposed Person (PEP)?",
//               style: TextStyle(fontSize: 17.sp, color: Color(0xffEBEEF5)),
//             ),
//             SizedBox(height: 12.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildSelectableChip("PEP", "Yes", 106.w),
//                 SizedBox(width: 20.w),
//                 _buildSelectableChip("PEP", "No", 106.w),
//               ],
//             ),

//             Spacer(),

//             SizedBox(
//               height: 52.h,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isFormComplete
//                     ? () {
//                         navi(linkBankScreen(), context);
//                       }
//                     : null, // Disabled when selections are incomplete
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isFormComplete
//                       ? Color(0xFF1DB954) // Green when enabled
//                       : Color(0xff2f2f2f), // Gray when disabled
//                   foregroundColor: Colors.white,
//                   disabledBackgroundColor: Color(0xff2f2f2f),
//                 ),
//                 child: Text(
//                   "Continue",
//                   style:
//                       TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.h),

//             /// Need Help Button
//             Center(child: constWidgets.needHelpButton(context)),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ Uses InkWell to handle chip selection dynamically
//   Widget _buildSelectableChip(String category, String value, double width) {
//     bool isSelected =
//         (category == "Settlement" && selectedSettlement == value) ||
//             (category == "PEP" && selectedPEP == value);

//     return InkWell(
//       onTap: () => _selectOption(category, value),
//       child: constWidgets.choiceChip(value, isSelected, context, width),
//     );
//   }
// }
