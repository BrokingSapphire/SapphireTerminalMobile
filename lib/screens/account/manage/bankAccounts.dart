import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Widget bankDetails(Map<String, dynamic> account, bool isDark) {
    return Container(
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
    );
  }

  Widget addBankButton(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: () {
          // Add functionality to navigate to a form or perform an action
          print("Add Bank Account tapped");
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
