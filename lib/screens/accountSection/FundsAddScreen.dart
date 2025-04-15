import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class fundsAddScreen extends StatefulWidget {
  const fundsAddScreen({super.key});

  @override
  State<fundsAddScreen> createState() => _fundsAddScreenState();
}

class _fundsAddScreenState extends State<fundsAddScreen> {
  String? selectedBank;
  int? selectedMethod;
  String selectedPayment = '';

  final List<Map<String, String>> banks = [
    {'name': 'Kotak Mahindra Bank', 'details': 'XXXX XXXX 2662'},
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leadingWidth: 32.w,
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Deposit Funds',
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
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Color(0xff2F2F2F)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Avl. Margin :',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white70),
                        ),
                        Text(
                          '  ₹ 2,532.00',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                        height: 60.h,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.currency_rupee,
                                color: Colors.white),
                            hintText: 'Enter amount',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,

                            // ✅ Unfocused Border (Gray Color #2F2F2F)
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Color(0xff2F2F2F), width: 1.5),
                            ),

                            // ✅ Focused Border (Optional: Set a different color when active)
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2), // White border when focused
                            ),

                            // ✅ Error Border (Optional: Red Border on Validation Error)
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),

                            // ✅ Disabled Border (Optional)
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Color(0xff2F2F2F), width: 1.5),
                            ),
                          ),
                        )),
                    SizedBox(height: 12.h),

                    // Select Bank Account
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff121413),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  height: 34.h,
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Select Bank Account",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            _buildBankTile(
                                'Kotak Mahindra Bank',
                                'XXXX XXXX 2662',
                                'assets/images/kotakbanklogo.png',
                                'kotak'),
                            Divider(
                              color: Color(0xff2F2F2F),
                              thickness: 1.5,
                              endIndent: 16.w,
                              indent: 16.w,
                            ),
                            _buildBankTile('ICICI Bank', 'XXXX XXXX 6485',
                                'assets/images/icici logo.png', 'icici'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff121413),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  height: 34.h,
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Select Payment Method",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  "assets/images/upi logo.png",
                                  height: 30.h,
                                  width: 30.w,
                                ),
                                iconColor: Colors.white70,
                                title: Text(
                                  "UPI",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                tilePadding: EdgeInsets
                                    .zero, // ✅ Removes extra padding that may cause the line
                                childrenPadding: EdgeInsets
                                    .zero, // ✅ Ensures no padding inside expanded content
                                backgroundColor: Colors
                                    .transparent, // ✅ Prevents line effect after expansion
                                collapsedBackgroundColor: Colors
                                    .transparent, // ✅ Keeps the collapsed state clean
                                shape:
                                    Border(), // ✅ Removes the default bottom border
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.w),
                                    child: Column(
                                      children: [
                                        PaymentOption(
                                          title: "Phone Pe",
                                          imagepath:
                                              "assets/images/phonepe logo.png",
                                          isSelected:
                                              selectedPayment == "Phone Pe",
                                          onTap: () {
                                            setState(() {
                                              selectedPayment = "Phone Pe";
                                            });
                                          },
                                        ),
                                        PaymentOption(
                                          title: "Google Pay",
                                          imagepath:
                                              "assets/images/google pay logo.png",
                                          isSelected:
                                              selectedPayment == "Google Pay",
                                          onTap: () {
                                            setState(() {
                                              selectedPayment = "Google Pay";
                                            });
                                          },
                                        ),
                                        PaymentOption(
                                          title: "Paytm",
                                          imagepath:
                                              "assets/images/paytm logo.png",
                                          isSelected:
                                              selectedPayment == "Paytm",
                                          onTap: () {
                                            setState(() {
                                              selectedPayment = "Paytm";
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                color: Color(0xff121413),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                          "assets/images/netbanking logo.png",
                                          height: 30.h,
                                          width: 30.w),
                                      SizedBox(width: 14.w),
                                      Text("Net Banking",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white70,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              //  tilePadding: EdgeInsets
                              //       .zero, // ✅ Removes extra padding that may cause the line
                              //   childrenPadding: EdgeInsets
                              //       .zero, // ✅ Ensures no padding inside expanded content
                              //   backgroundColor: Colors
                              // .transparent, // ✅ Prevents line effect after expansion
                              collapsedBackgroundColor: Colors
                                  .transparent, // ✅ Keeps the collapsed state clean
                              shape: Border(),
                              leading: Image.asset(
                                  "assets/images/bank transfer.png",
                                  height: 30.h,
                                  width: 30.w),
                              iconColor: Colors.white70,
                              title: Text(
                                "Bank Transfer",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              children: [
                                Container(
                                    padding: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xff121413),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "Bank Name",
                                                    "ICICI Bank Limited",
                                                    alignment: TextAlign.left)),
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "Account Holder",
                                                    "Sapphire Broking",
                                                    alignment:
                                                        TextAlign.right)),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "Account Number",
                                                    "590005004423",
                                                    alignment: TextAlign.left)),
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "Account Type",
                                                    "Current Account",
                                                    alignment:
                                                        TextAlign.right)),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "Bank Branch",
                                                    "Civil Lines, Nagpur",
                                                    alignment: TextAlign.left)),
                                            Expanded(
                                                child: BankDetailColumn(
                                                    "IFSC Code", "ICIC0000059",
                                                    alignment:
                                                        TextAlign.right)),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget _buildBankTile(
      String bankName, String accountNumber, String iconPath, String value) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            selectedBank = value;
          });
        },
        child: Container(
          width: 18.w,
          height: 18.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  selectedBank == value ? Colors.green : Colors.grey.shade700,
              width: 4.w,
            ),
          ),
          child: selectedBank == value
              ? Center(
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                )
              : null,
        ),
      ),
      title: GestureDetector(
        behavior:
            HitTestBehavior.opaque, // Ensures the whole title area is tappable
        onTap: () {
          setState(() {
            selectedBank = value;
          });
        },
        child: Row(
          children: [
            Image.asset(iconPath, height: 30.h, width: 30.w),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
                Text(
                  accountNumber,
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankDetailColumn extends StatelessWidget {
  final String label;
  final String value;
  final TextAlign alignment;

  BankDetailColumn(this.label, this.value, {this.alignment = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(color: Color(0xffC9CACC), fontSize: 12.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
              color: Color(0xffEBEEF5),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600),
          textAlign: alignment,
        ),
      ],
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String title;
  final String imagepath;
  final bool isSelected;
  final VoidCallback onTap;

  PaymentOption({
    required this.title,
    required this.imagepath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: Image.asset(
        imagepath,
        width: 20.w,
        height: 20.h,
        fit: BoxFit.cover,
      ),
      title: GestureDetector(
        // borderRadius: BorderRadius.circular(20.r),
        behavior: HitTestBehavior.opaque,
        onTap: onTap, // <-- triggers selection
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
      trailing: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 18.w,
          height: 18.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade700,
              width: 4,
            ),
          ),
          child: isSelected
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
      ),
    );
  }
}
