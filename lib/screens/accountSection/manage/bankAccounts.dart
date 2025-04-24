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

  Widget bankDetails(Map<String, dynamic> account) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff2f2f2f)),
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
                            fontWeight: FontWeight.w500, fontSize: 13.sp),
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
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                      Text(
                        account['accountNumber'],
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffFAFAFA)),
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
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                      Text(
                        account['ifsc'],
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffFAFAFA)),
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
                            fontSize: 11.sp, color: const Color(0xffC9CACC)),
                      ),
                      Text(
                        account['branch'],
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xffFAFAFA)),
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

  Widget addBankButton() {
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
            const Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              "Add Bank Account",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, size: 15.sp)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Bank Details",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xff2f2f2f),
            height: 1,
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: ListView.builder(
                itemCount: dummyBankAccounts.length + 1, // +1 for the button
                itemBuilder: (context, index) {
                  if (index < dummyBankAccounts.length) {
                    return bankDetails(dummyBankAccounts[index]);
                  } else {
                    return addBankButton();
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
