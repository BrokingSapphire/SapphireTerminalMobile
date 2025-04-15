import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/FundsAddScreen.dart';
import 'package:sapphire/screens/accountSection/FundsWithdrawScreen.dart';

class FundsScreen extends StatefulWidget {
  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Funds",
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
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xff2F2F2F),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xff121413)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Available Margin",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.green,
                                    size: 17,
                                  ),
                                  padding: EdgeInsets
                                      .zero, // ✅ Removes extra padding from the button
                                  constraints:
                                      BoxConstraints(), // ✅ Shrinks button to icon size
                                  visualDensity: VisualDensity
                                      .compact, // ✅ Reduces button spacing
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(0, -2),
                              child: Text(
                                '₹ 1,12,532.00',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(
                              color: Color(0xff2F2F2F),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    navi(fundsAddScreen(), context);
                                  },
                                  child: Container(
                                    height: 42.h,
                                    width: 140.w,
                                    child: Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          Text("Deposit"),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: Colors.green,
                                          )
                                        ])),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff2F2F2F)),
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                  ),
                                ),
                                SizedBox(
                                  width: 28.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    navi(fundsWithdrawScreen(), context);
                                  },
                                  child: Container(
                                    height: 42.h,
                                    width: 140.w,
                                    child: Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          Text("Withdraw"),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SvgPicture.asset(
                                            "assets/svgs/withdraw.svg",
                                            height: 18.h,
                                            width: 18.w,
                                            colorFilter: ColorFilter.mode(
                                              Colors.green,
                                              BlendMode.srcIn,
                                            ),
                                          )
                                        ])),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff2F2F2F)),
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xff121413)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cash Balance",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "₹ 12,532.00",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Margin from Pledge",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "₹ 13,834.00",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(
                      color: Color(0xff2F2F2F),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xff121413)),
                      child: ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 17,
                        ),
                        title: Text(
                          "Transaction History",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        leading: SvgPicture.asset(
                          "assets/svgs/transaction-svgrepo-com.svg",
                          color: Color(0xFFc9cacc),
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Balance",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                        Text(
                          "₹1,00,000",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cash Balance",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                              Text(
                                "₹40,000",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Collateral Balance",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                              Text(
                                "₹60,000",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xffC9CACC),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Divider(
                        color: Color(0xff2F2F2F),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Margin Utilised",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                        Text(
                          "₹5,00,000",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Margin",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Span Margin",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exposure Margin",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Amount",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Commodity Additional Margin",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Cash Intraday / MTF Margin",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Premiums",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FNO Premium",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Currency Premium",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Commodity Premium",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                                Text(
                                  "₹60,000",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Color(0xffC9CACC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Divider(
                        color: Color(0xff2F2F2F),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Withdrawable Balance",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                        Text(
                          "₹2,00,000",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
