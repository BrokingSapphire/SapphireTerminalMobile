// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sapphire/screens/signUp/panDetails.dart';

// import '../../main.dart';
// import '../../utils/constWidgets.dart';
// import 'mobileOtp.dart';

// class SignupPaymentScreen extends StatefulWidget {
//   const SignupPaymentScreen({super.key});

//   // @override
//   State<SignupPaymentScreen> createState() => _SignupPaymentScreenState();
// }

// class _SignupPaymentScreenState extends State<SignupPaymentScreen> {
//   void showPaymentBottomSheet(BuildContext context) {
//     TextEditingController cardNumberController = TextEditingController();
//     TextEditingController expiryController = TextEditingController();
//     TextEditingController cvvController = TextEditingController();
//     TextEditingController nameController = TextEditingController();

//     String? cardError;
//     String? expiryError;
//     String? cvvError;
//     String? nameError;

//     void validateInputs() {
//       String cardNumber = cardNumberController.text.replaceAll('-', '').trim();
//       String expiry = expiryController.text.replaceAll('/', '').trim();
//       String cvv = cvvController.text.trim();
//       String name = nameController.text.trim();

//       bool isValid = true;

//       // Card Number Validation
//       if (cardNumber.length != 16 ||
//           !RegExp(r'^\d{16}$').hasMatch(cardNumber)) {
//         cardError = "Enter a valid 16-digit card number";
//         isValid = false;
//       } else {
//         cardError = null;
//       }

//       // Expiry Date Validation (MM/YY)
//       if (expiry.length != 4 ||
//           !RegExp(r'^(0[1-9]|1[0-2])\d{2}$').hasMatch(expiry)) {
//         expiryError = "Enter valid MM/YY format";
//         isValid = false;
//       } else {
//         expiryError = null;
//       }

//       // CVV Validation
//       if (cvv.length != 3 || !RegExp(r'^\d{3}$').hasMatch(cvv)) {
//         cvvError = "Enter valid 3-digit CVV";
//         isValid = false;
//       } else {
//         cvvError = null;
//       }

//       // Cardholder Name Validation
//       if (name.isEmpty) {
//         nameError = "Cardholder name is required";
//         isValid = false;
//       } else {
//         nameError = null;
//       }

//       if (isValid) {
//         Navigator.pop(context); // Close bottom sheet on valid input
//         // Proceed with payment logic
//       }
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//               },
//               behavior: HitTestBehavior.opaque,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 16.w,
//                   right: 16.w,
//                   top: 20.h,
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// **Header with Close Button**
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Pay via Card",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 17.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close, color: Colors.white),
//                           onPressed: () => Navigator.pop(context),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 10.h),

//                     /// **Card Number Input**
//                     SizedBox(
//                       height: 52.h,
//                       child: TextField(
//                         controller: cardNumberController,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.left,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(16),
//                           CardNumberInputFormatter(),
//                         ],
//                         decoration: _buildInputDecoration(
//                           "Enter Card Number",
//                           cardError,
//                           setState,
//                         ).copyWith(
//                           hintText: "Enter Card Number",
//                           hintStyle: TextStyle(color: Colors.white54),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 15.h, horizontal: 15.w),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 10.h),

//                     /// **Expiry & CVV Fields**
//                     Row(
//                       children: [
//                         /// **Expiry Date Input**
//                         Expanded(
//                           child: SizedBox(
//                             height: 52.h,
//                             child: TextField(
//                               controller: expiryController,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 LengthLimitingTextInputFormatter(4),
//                                 ExpiryDateInputFormatter(),
//                               ],
//                               decoration: _buildInputDecoration(
//                                 "Expiry Date (MM/YY)",
//                                 expiryError,
//                                 setState,
//                               ).copyWith(
//                                 contentPadding: EdgeInsets.symmetric(
//                                     vertical: 15.h, horizontal: 15.w),
//                               ),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w),

//                         /// **CVV Input**
//                         SizedBox(
//                           width: 151.w,
//                           height: 52.h,
//                           child: TextField(
//                             controller: cvvController,
//                             keyboardType: TextInputType.number,
//                             obscureText: true,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               LengthLimitingTextInputFormatter(3),
//                             ],
//                             decoration: _buildInputDecoration(
//                               "CVV",
//                               cvvError,
//                               setState,
//                             ).copyWith(
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 15.h, horizontal: 15.w),
//                             ),
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),

//                     /// **Cardholder Name Input**
//                     SizedBox(
//                       height: 52.h,
//                       child: TextField(
//                         controller: nameController,
//                         decoration: _buildInputDecoration(
//                           "Enter Holder Name",
//                           nameError,
//                           setState,
//                         ).copyWith(
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 15.h, horizontal: 15.w),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),

//                     /// **Pay Button**
//                     constWidgets.greenButton("Pay ₹99", onTap: () {
//                       setState(() {
//                         validateInputs();
//                       });
//                     }),
//                     SizedBox(height: 10.h),

//                     /// **Security Disclaimer**
//                     Center(
//                       child: Text(
//                         "Your card payment will be processed securely as per RBI guidelines.\n₹99 will be debited from your card.",
//                         textAlign: TextAlign.center,
//                         style:
//                             TextStyle(color: Colors.white54, fontSize: 12.sp),
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   /// **Input Decoration with Error Handling**
//   InputDecoration _buildInputDecoration(
//       String hint, String? errorText, Function setState) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(color: Colors.white54),
//       errorText: errorText,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(color: Color(0xff2f2f2f)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(color: Color(0xff2f2f2f)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(color: Color(0xff1db954), width: 2.w),
//       ),
//     );
//   }

//   void showNetBankingBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           behavior: HitTestBehavior.opaque,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with Close Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Pay via Net Banking",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 10),

//                 // Search Bank Field
//                 SizedBox(
//                   height: 52.h,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Color(0xff232323), // Background color
//                       hintText: "Search Bank Name",
//                       hintStyle: TextStyle(color: Color(0xffC9CACC)),
//                       prefixIcon: IconButton(
//                         icon: SvgPicture.asset(
//                           "assets/icons/search.svg",
//                           width: 20, // Set width to 5
//                           height: 20, // Set height to 5
//                         ),
//                         onPressed:
//                             () {}, // You can keep it empty or define an action
//                       ),

//                       border: OutlineInputBorder(
//                         borderRadius:
//                             BorderRadius.circular(8.r), // Rounded corners
//                         borderSide: BorderSide.none, // No border
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius:
//                             BorderRadius.circular(8.r), // Rounded corners
//                         borderSide: BorderSide.none, // No border
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius:
//                             BorderRadius.circular(8.r), // Rounded corners
//                         borderSide: BorderSide.none, // No border
//                       ),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),

//                 SizedBox(height: 20.h),

//                 // Popular Banks List
//                 Text(
//                   "Popular Banks",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),

//                 // Bank List Items
//                 Column(
//                   children: [
//                     "State Bank of India",
//                     "HDFC Bank",
//                     "ICICI Bank",
//                     "Axis Bank"
//                   ]
//                       .map((bankName) => ListTile(
//                             leading: SizedBox(
//                                 height: 25.h,
//                                 width: 25.w,
//                                 child:
//                                     SvgPicture.asset("assets/images/upi.svg")),
//                             title: Text(bankName,
//                                 style: TextStyle(color: Colors.white)),
//                             trailing: Icon(Icons.arrow_forward_ios,
//                                 color: Colors.white54, size: 16),
//                             onTap: () =>
//                                 showConfirmationDialog(context, bankName),
//                           ))
//                       .toList(),
//                 ),

//                 SizedBox(height: 20),

//                 // Disclaimer
//                 Center(
//                   child: Text(
//                     "Your net banking payment will be processed securely as per RBI guidelines.\n₹99 will be debited from your bank account.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white54, fontSize: 12),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void showUPIPaymentBottomSheet(BuildContext context) {
//     TextEditingController upiController = TextEditingController();
//     bool isUPIInvalid = false;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Ensures it adjusts height dynamically

//       builder: (context) {
//         return StatefulBuilder(
//           // Needed to update UI dynamically
//           builder: (context, setState) {
//             return GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//               },
//               behavior: HitTestBehavior.opaque,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 16.w,
//                   right: 16.w,
//                   top: 18.h,
//                   bottom: MediaQuery.of(context).viewInsets.bottom +
//                       20, // Adjust for keyboard
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// **Header with Close Button**
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Pay via UPI",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.close, color: Colors.white),
//                             onPressed: () => Navigator.pop(context),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 10.h),

//                       /// **UPI App Options**
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           upiAppButton("PhonePe", "assets/images/phonepay.svg"),
//                           upiAppButton("GPay", "assets/images/gpay.svg"),
//                           upiAppButton("Paytm UPI", "assets/images/paytm.svg"),
//                         ],
//                       ),
//                       SizedBox(height: 20),

//                       /// **OR Divider**
//                       Row(
//                         children: [
//                           Expanded(child: Divider(color: Colors.white24)),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Text("OR",
//                                 style: TextStyle(color: Colors.white54)),
//                           ),
//                           Expanded(child: Divider(color: Colors.white24)),
//                         ],
//                       ),
//                       SizedBox(height: 10),

//                       /// **UPI ID Input Field**
//                       TextField(
//                         controller: upiController,
//                         decoration: InputDecoration(
//                           labelText: "UPI ID",
//                           labelStyle: TextStyle(color: Colors.white),
//                           hintStyle: TextStyle(color: Colors.white54),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: isUPIInvalid
//                                       ? Colors.red
//                                       : Colors.transparent)),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                                 color: isUPIInvalid ? Colors.red : Colors.green,
//                                 width: 2.0),
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(height: 20),

//                       /// **Verify and Pay Button**
//                       constWidgets.greenButton("Verify and Pay ₹99", onTap: () {
//                         if (!_validateUPI(upiController.text)) {
//                           setState(() => isUPIInvalid = true);

//                           // Show error snackbar
//                           constWidgets.snackbar(
//                               "Enter a valid UPI ID (e.g., yourname@upi)",
//                               Colors.red,
//                               context);

//                           // Clear UPI ID after a short delay
//                           Future.delayed(Duration(seconds: 1), () {
//                             setState(() => isUPIInvalid = false);
//                             upiController.clear();
//                           });
//                         } else {
//                           // Proceed to next step
//                           navi(PanDetails(), context);
//                         }
//                       }),
//                       SizedBox(height: 10),

//                       /// **Disclaimer**
//                       Center(
//                         child: Text(
//                           "Your UPI payment will be processed securely as per RBI guidelines.\n₹99 will be debited from your linked account.",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white54, fontSize: 12),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   /// **UPI Validation Function**
//   bool _validateUPI(String upiID) {
//     RegExp upiRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z]+$');
//     return upiRegex.hasMatch(upiID);
//   }

//   void showConfirmationDialog(BuildContext context, String bankName) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Colors.black,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Continue?",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "You will be redirected to $bankName payment page",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 14.sp),
//                     ),
//                   ],
//                 ),
//               ),

//               // Cancel & Proceed Buttons
//               Row(
//                 children: [
//                   Expanded(
//                       child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 45.h,
//                       decoration: BoxDecoration(
//                           color: const Color(0xffC9CACC),
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(15.r))),
//                       child: const Center(
//                         child: Text(
//                           "Cancel",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   )),
//                   Expanded(
//                       child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 45.h,
//                       decoration: BoxDecoration(
//                           color: const Color(0xff1DB954),
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(15.r))),
//                       child: const Center(
//                         child: Text(
//                           "Proceed",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

// // UPI App Button Widget
//   Widget upiAppButton(String name, String imageLink) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 40.h,
//           width: 40.w,
//           child: SvgPicture.asset(
//             imageLink,
//             semanticsLabel: 'Dart Logo',
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
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
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           children: [
//             RichText(
//               textAlign: TextAlign.start,
//               text: TextSpan(
//                 style: TextStyle(
//                   fontFamily: "SFPro", // ✅ Explicitly specify font family
//                   fontWeight: FontWeight.w600,
//                   fontSize: 21.sp,
//                   color: Colors.white70,
//                 ),
//                 children: [
//                   TextSpan(
//                     text:
//                         "Unlock your Trading Potential - Get Started for Just ",
//                     style: TextStyle(
//                       fontFamily: "SFPro", // ✅ Ensure consistency
//                       color: Colors.white,
//                     ),
//                   ),
//                   TextSpan(
//                     text: " ₹99/- only",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontFamily: "SFPro", // ✅ Apply here too
//                       color: Color(0xff1db954),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24.h),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: const Color(0xFF121413),
//                   borderRadius: BorderRadius.circular(8.r)),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 8.h,
//                     ),
//                     Text(
//                       "Select Payment Option",
//                       style: TextStyle(
//                           fontSize: 17.sp, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(height: 6.h),
//                     InkWell(
//                       onTap: () {
//                         showPaymentBottomSheet(context);
//                       },
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 2, vertical: 18),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                   height: 20.h,
//                                   width: 30.w,
//                                   child: Image.asset("assets/images/visa.png")),
//                               SizedBox(
//                                 width: 20.w,
//                               ),
//                               Text(
//                                 "Debit / Credit Card",
//                                 style: TextStyle(
//                                     fontSize: 15.sp, color: Color(0xffEBEEF5)),
//                               ),
//                               Spacer(),
//                               Icon(Icons.arrow_forward_ios_outlined,
//                                   size: 15, color: Color(0xffEBEEF5)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(
//                       height: 1, // Reduced height of the divider
//                       thickness: 1, // Reduced thickness
//                       indent: 4,
//                       endIndent: 4,
//                       color: Color(
//                           0xff2f2f2f), // Optional: specify color if needed
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showUPIPaymentBottomSheet(context);
//                       },
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 2, vertical: 18),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                   height: 20.h,
//                                   width: 30.w,
//                                   child: SvgPicture.asset(
//                                       "assets/images/upi.svg")),
//                               SizedBox(
//                                 width: 20.w,
//                               ),
//                               Text(
//                                 "UPI",
//                                 style: TextStyle(
//                                     fontSize: 15.sp, color: Color(0xffEBEEF5)),
//                               ),
//                               Spacer(),
//                               Icon(Icons.arrow_forward_ios_outlined,
//                                   size: 15, color: Color(0xffEBEEF5)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(
//                       height: 1, // Reduced height of the divider
//                       thickness: 1, // Reduced thickness
//                       indent: 4,
//                       endIndent: 4,
//                       color: Color(
//                           0xff2f2f2f), // Optional: specify color if needed
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showNetBankingBottomSheet(context);
//                       },
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 2, vertical: 18),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                   height: 20.h,
//                                   width: 30.w,
//                                   child: Image.asset(
//                                       "assets/images/netbanking.png")),
//                               SizedBox(
//                                 width: 20.w,
//                               ),
//                               Text(
//                                 "Netbanking",
//                                 style: TextStyle(
//                                     fontSize: 15.sp, color: Color(0xffEBEEF5)),
//                               ),
//                               Spacer(),
//                               Icon(Icons.arrow_forward_ios_outlined,
//                                   size: 15, color: Color(0xffEBEEF5)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 24.h,
//             ),

//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6.r), // Rounded corners
//                 border: Border.all(
//                   color: Color(0xff2f2f2f), // Border color
//                   width: 1.5, // Border width
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Instant Account Activation – Start investing within minutes",
//                       style: TextStyle(
//                         color: const Color((0xffEBEEF5)),
//                         fontSize: 11.sp,
//                       ),
//                     ),
//                     SizedBox(height: 12.h),
//                     Row(
//                       children: [
//                         Icon(Icons.check, color: Colors.white, size: 14.sp),
//                         SizedBox(width: 8.w),
//                         Text(
//                           "Secure & Affordable Trading",
//                           style: TextStyle(
//                               color: const Color((0xffC9CACC)),
//                               fontSize: 11.sp),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 5.h),
//                     Row(
//                       children: [
//                         Icon(Icons.check, color: Colors.white, size: 14.sp),
//                         SizedBox(width: 8.w),
//                         Text(
//                           "Trusted by Investors",
//                           style: TextStyle(
//                               color: const Color((0xffC9CACC)),
//                               fontSize: 11.sp),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 5.h),
//                     Row(
//                       children: [
//                         Icon(Icons.check, color: Colors.white, size: 14.sp),
//                         SizedBox(width: 8.w),
//                         Text(
//                           "SEBI-Registered & Safe",
//                           style: TextStyle(
//                               color: const Color((0xffC9CACC)),
//                               fontSize: 11.sp),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(child: SizedBox()),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 25.h,
//                   width: 25.w,
//                   child: Image.asset("assets/images/safe.png"),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Text(
//                   "100% safe\n& Secure Payment",
//                   style: TextStyle(
//                       color: const Color(0xFFA9A9A9), fontSize: 13.sp),
//                 )
//               ],
//             ),
//             SizedBox(height: 30.h),

//             /// Need Help Button
//             Center(
//               child: Center(child: constWidgets.needHelpButton(context)),
//             ),
//             SizedBox(height: 30.h),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CardNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String digits =
//         newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
//     List<String> parts = [];
//     for (int i = 0; i < digits.length; i += 4) {
//       parts.add(
//           digits.substring(i, i + 4 > digits.length ? digits.length : i + 4));
//     }
//     return TextEditingValue(
//       text: parts.join('-'),
//       selection: TextSelection.collapsed(offset: parts.join('-').length),
//     );
//   }
// }

// /// **Formats expiry date input with `/` after MM**
// class ExpiryDateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String digits =
//         newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
//     if (digits.length > 2) {
//       digits = '${digits.substring(0, 2)}/${digits.substring(2)}';
//     }
//     return TextEditingValue(
//       text: digits,
//       selection: TextSelection.collapsed(offset: digits.length),
//     );
//   }
// }
