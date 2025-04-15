import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constWidgets.dart';

class fundsWithdrawScreen extends StatefulWidget {
  const fundsWithdrawScreen({super.key});

  @override
  State<fundsWithdrawScreen> createState() => _fundsWithdrawScreenState();
}

class _fundsWithdrawScreenState extends State<fundsWithdrawScreen> {
  String? selectedBank;
  String _selectedValue = "";

  final List<Map<String, String>> banks = [
    {'name': 'Kotak Mahindra Bank', 'details': 'XXXX XXXX 2662'},
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            leadingWidth: 32.w,
            backgroundColor: Colors.black,
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Withdraw Funds',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            )),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Divider(color: Color(0xff2F2F2F)),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7.h),

                      // Withdrawable Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Withdrawable amount :',
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.white70),
                          ),
                          Text(
                            '  ₹ 12,532.00',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Amount Input
                      SizedBox(
                        height: 60.h,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.currency_rupee,
                              color: Colors.white,
                              size: 20,
                            ),
                            hintText: 'Enter amount',
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Color(0xff2F2F2F), width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Instant / Regular
                      Container(
                        height: 60.h,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff2F2F2F)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            _buildCustomRadioButton("Instant"),
                            SizedBox(width: 110.w),
                            _buildCustomRadioButton("Regular"),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Bank Selection
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff121413),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 34.h,
                                  width: 2.w,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 20.w),
                                Text(
                                  "Select bank account",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            _buildBankTile(
                                'Kotak Mahindra Bank',
                                'XXXX XXXX 2662',
                                'assets/images/kotakbanklogo.png',
                                'kotak'),
                            Divider(
                              indent: 16.w,
                              endIndent: 16.w,
                              color: Color(0xff2F2F2F),
                            ),
                            _buildBankTile('ICICI Bank', 'XXXX XXXX 6485',
                                'assets/images/icici logo.png', 'icici'),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Transaction History
                      Container(
                        height: 60.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Color(0xff121413),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.compare_arrows_rounded,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10.w),
                                Text("Transaction History",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp)),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 120.h),

                      // Info box
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF2F2708),
                          border:
                              Border.all(color: Color(0xFFB58E00), width: 1.w),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "Withdrawal requests between 5:00 AM and 5:00 PM are credited the same day. "
                          "Requests placed after 5:00 PM and before 5:00 AM are processed the next working day.",
                          style:
                              TextStyle(fontSize: 11.sp, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Proceed button
                      constWidgets.greenButton("Proceed"),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bank Tile
  Widget _buildBankTile(
      String bankName, String accountNumber, String iconPath, String value) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          selectedBank = value;
        });
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        trailing: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  selectedBank == value ? Colors.green : Colors.grey.shade700,
              width: 2.5.w,
            ),
            color: selectedBank == value ? Colors.green : Colors.transparent,
          ),
          child: selectedBank == value
              ? Center(
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                )
              : null,
        ),
        title: Row(
          children: [
            Image.asset(iconPath, height: 30.h, width: 30.w),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bankName,
                    style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                Text(accountNumber,
                    style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Radio
  Widget _buildCustomRadioButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedValue = title;
        });
      },
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedValue == title
                    ? Colors.green
                    : Colors.grey.shade700,
                width: 2.5.w,
              ),
              color:
                  _selectedValue == title ? Colors.green : Colors.transparent,
            ),
            child: _selectedValue == title
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(title, style: TextStyle(fontSize: 15.sp, color: Colors.white)),
        ],
      ),
    );
  }
}
