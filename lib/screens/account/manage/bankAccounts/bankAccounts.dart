import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/utils/constWidgets.dart';

class BankAccounts extends StatefulWidget {
  const BankAccounts({super.key});

  @override
  State<BankAccounts> createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  // Dummy data model for bank account
  final List<Map<String, dynamic>> dummyBankAccounts = [
    {
      'bankName': 'Bank of Baroda - 8056',
      'isPrimary': true,
      'accountNumber': '7998989598',
      'ifsc': 'BARB0MANEAD',
      'branch': 'Maneada',
    },
    {
      'bankName': 'State Bank of India - 1234',
      'isPrimary': false,
      'accountNumber': '1111222233',
      'ifsc': 'SBIN0001234',
      'branch': 'Main Branch',
    },
  ];

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, dynamic> account) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: isDark ? Color(0xff121413) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            width: 350.w,
            padding: EdgeInsets.all(24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Delete Bank Account",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Do you really want to Delete?",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 224.w,
                  height: 38.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle actual delete action here
                      Navigator.pop(context);
                      // You would typically remove the bank account from your data source here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE53935),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: 224.w,
                  height: 38.h,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBankDetailsBottomSheet(
      BuildContext context, Map<String, dynamic> account) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account['bankName'],
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Divider(
                color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                thickness: 1,
              ),
              SizedBox(height: 16.h),

              // Account Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account Number",
                    style: TextStyle(
                      color: isDark ? Color(0xffC9CACC) : Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    account['accountNumber'],
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // IFSC Code
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IFSC Code",
                    style: TextStyle(
                      color: isDark ? Color(0xffC9CACC) : Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    account['ifsc'],
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Branch
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Branch",
                    style: TextStyle(
                      color: isDark ? Color(0xffC9CACC) : Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    account['branch'],
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Close the bottom sheet first
                          // Navigator.pop(context);
                          // Show delete confirmation dialog
                          _showDeleteConfirmationDialog(context, account);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE53935),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle edit action
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  final TextEditingController _phoneOtpController = TextEditingController();

  // Timer for OTP resend
  bool _canResendOtp = false;
  int _remainingSeconds = 2;
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

  void _showEnterOtp(BuildContext context, bool isDark) {
    // Reset timer state and OTP field
    _canResendOtp = false;
    _remainingSeconds = 2;
    _phoneOtpController.clear();

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

          // Add listener to OTP controller to update UI when typing
          _phoneOtpController.addListener(() {
            setModalState(() {});
          });

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
                        controller: _phoneOtpController,
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
                          onPressed: _phoneOtpController.text.length == 6
                              ? () {
                                  // Close bottom sheet and navigate to change new PIN screen
                                  Navigator.pop(context);
                                  // navi(changeNewPinScreen(), context);
                                }
                              : null,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _phoneOtpController.text.length == 6
                                    ? Color(0xFF1DB954)
                                    : Color(0xff2f2f2f),
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

  Widget bankDetails(Map<String, dynamic> account, bool isDark) {
    return GestureDetector(
        onTap: () {
          _showBankDetailsBottomSheet(context, account);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            border: Border.all(
                color: isDark ? const Color(0xff2f2f2f) : Color(0xffD1D5DB)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  color: Colors.grey,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            account['bankName'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          if (account['isPrimary'])
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xffbaa461).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                "Primary",
                                style: TextStyle(
                                  color: const Color(0xffE9A256),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "A/c Number:",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffC9CACC)
                                    : Colors.black),
                          ),
                          Text(
                            account['accountNumber'],
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffFAFAFA)
                                    : Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "IFS code:",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffC9CACC)
                                    : Colors.black),
                          ),
                          Text(
                            account['ifsc'],
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffFAFAFA)
                                    : Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Branch:",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffC9CACC)
                                    : Colors.black),
                          ),
                          Text(
                            account['branch'],
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: isDark
                                    ? const Color(0xffFAFAFA)
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showAddBankAccountBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String selectedAccountType = "Savings";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Bank Account",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Divider(
                      color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                      thickness: 1,
                    ),
                    SizedBox(height: 10.h),

                    // Account Number
                    Text(
                      "Account Number",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      height: 40.h,
                      child: Center(
                        child: TextField(
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 13.sp),
                          decoration: InputDecoration(
                            hintText: "Number",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor:
                                isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xFF2F2F2F)
                                    : Color(0xFFE5E7EB),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xFF2F2F2F)
                                    : Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // IFSC Code
                    Text(
                      "IFSC Code",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 40.h,
                      child: Center(
                        child: TextField(
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 13.sp),
                          decoration: InputDecoration(
                            hintText: "Code",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor:
                                isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xFF2F2F2F)
                                    : Color(0xFFE5E7EB),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Color(0xFF2F2F2F)
                                    : Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          textCapitalization: TextCapitalization.characters,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Account Type
                    Text(
                      "Account Type",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        // Savings Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAccountType = "Savings";
                            });
                          },
                          child: constWidgets.choiceChip(
                              "Savings",
                              selectedAccountType == "Savings",
                              context,
                              100.w,
                              isDark),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAccountType = "Current";
                            });
                          },
                          child: constWidgets.choiceChip(
                              "Current",
                              selectedAccountType == "Current",
                              context,
                              100.w,
                              isDark),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Info message
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Color(0xFF3A3A3A).withOpacity(0.5)
                            : Color(0xFFF4F4F9),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/info.svg",
                            color: Color(0xFF1DB954),
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "A nominal fee of ₹5 plus GST will be deducted as a bank addition charge.",
                              style: TextStyle(
                                color:
                                    isDark ? Color(0xFFC9CACC) : Colors.black,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Continue button
                    constWidgets.greenButton("Continue", onTap: () {
                      _showEnterOtp(context, isDark);
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget addBankButton(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: () {
          _showAddBankAccountBottomSheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.add, color: isDark ? Colors.white : Colors.black),
            SizedBox(width: 8.w),
            Text(
              "Add Bank Account",
              style: TextStyle(
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,
                size: 15.sp, color: isDark ? Colors.white : Colors.black)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Bank Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
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
            color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: ListView.builder(
                itemCount: dummyBankAccounts.length + 1, // +1 for the button
                itemBuilder: (context, index) {
                  if (index < dummyBankAccounts.length) {
                    return bankDetails(dummyBankAccounts[index], isDark);
                  } else {
                    return addBankButton(isDark);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
