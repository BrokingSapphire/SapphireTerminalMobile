// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sapphire/main.dart';
// import 'package:sapphire/screens/signUp/rasScreen.dart';

// import '../../utils/constWidgets.dart';

// class YourInvestmentProfile extends StatefulWidget {
//   const YourInvestmentProfile({super.key});

//   @override
//   State<YourInvestmentProfile> createState() => _YourInvestmentProfileState();
// }

// class _YourInvestmentProfileState extends State<YourInvestmentProfile> {
//   double width2 = 0;
//   double width3 = 0;

//   String? selectedExperience;
//   String? selectedIncome;

//   /// ✅ Function to check if both required fields are selected
//   bool get isFormComplete =>
//       selectedExperience != null && selectedIncome != null;

//   /// ✅ Updates selected option and refreshes UI
//   void _selectOption(String category, String value) {
//     setState(() {
//       if (category == "Trading Experience") {
//         selectedExperience = value;
//       } else if (category == "Income") {
//         selectedIncome = value;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     width2 = MediaQuery.of(context).size.width / 2 - 32;
//     width3 = MediaQuery.of(context).size.width / 3 - 15;

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
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 8.h),
//               constWidgets.topProgressBar(1, 4, context),
//               SizedBox(height: 24.h),
//               Text(
//                 "Your Investment Profile",
//                 style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 16.h),

//               /// ✅ TRADING EXPERIENCE SELECTION
//               Text(
//                 "Trading Experience",
//                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 12.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildSelectableChip(
//                       "Trading Experience", "No experience", width2),
//                   _buildSelectableChip("Trading Experience", "<1 year", width2),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildSelectableChip(
//                       "Trading Experience", "1-5 years", width2),
//                   _buildSelectableChip(
//                       "Trading Experience", "5-10 years", width2),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _buildSelectableChip(
//                       "Trading Experience", "10+ years", width2),
//                 ],
//               ),
//               SizedBox(height: 18.h),

//               /// ✅ INCOME SELECTION
//               Text(
//                 "Income",
//                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 12.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildSelectableChip("Income", "<1 lakh", width3),
//                   _buildSelectableChip("Income", "1 Lakh - 5 Lakh", width3),
//                   _buildSelectableChip("Income", "5 Lakh - 10 Lakh", width3),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildSelectableChip("Income", "10 Lakh - 25 Lakh", width3),
//                   _buildSelectableChip("Income", "25 Lakh - 1 Crore", width3),
//                   _buildSelectableChip("Income", "More than 1 CR", width3),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),

//       /// ✅ BOTTOM NAVIGATION BUTTON
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 52.h,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isFormComplete
//                     ? () {
//                         // navi(rasScreen(), context);
//                       }
//                     : null, // Disabled when selections are incomplete
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       isFormComplete ? Color(0xFF1DB954) : Color(0xff2f2f2f),
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
//             Center(child: constWidgets.needHelpButton(context)),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ Uses InkWell to update selection dynamically
//   Widget _buildSelectableChip(String category, String value, double width) {
//     bool isSelected =
//         (category == "Trading Experience" && selectedExperience == value) ||
//             (category == "Income" && selectedIncome == value);

//     return InkWell(
//       onTap: () => _selectOption(category, value),
//       child: constWidgets.choiceChip(value, isSelected, context, width),
//     );
//   }
// }
