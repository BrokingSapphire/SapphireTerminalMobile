import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class GiftStocks extends StatefulWidget {
  const GiftStocks({super.key});

  @override
  State<GiftStocks> createState() => _GiftStocksState();
}

class _GiftStocksState extends State<GiftStocks> {
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
              "Gift Securities",
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
            Divider(color: Color(0xff2F2F2F)), // Full-width divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  SvgPicture.asset("assets/svgs/gift.svg"),
                  SizedBox(height: 38.h),
                  Text(
                    "Gift your favorite stocks, mutual funds,\nand ETFs to your friends and family",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(6.r), // Rounded corners
                      border: Border.all(
                        color: Color(0xff2f2f2f), // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gift Stocks, Mutual Funds & ETFs with Sapphire Broking",
                            style: TextStyle(
                              color: const Color((0xffEBEEF5)),
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(Icons.check,
                                  color: Colors.white, size: 14.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "Choose stocks, mutual funds, or ETFs from your portfolio",
                                style: TextStyle(
                                    color: const Color((0xffC9CACC)),
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Icon(Icons.check,
                                  color: Colors.white, size: 14.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "Recipient gets a notification to accept the gift",
                                style: TextStyle(
                                    color: const Color((0xffC9CACC)),
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Icon(Icons.check,
                                  color: Colors.white, size: 14.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "If they don’t have an account, they can sign up to receive it",
                                style: TextStyle(
                                    color: const Color((0xffC9CACC)),
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Icon(Icons.check,
                                  color: Colors.white, size: 14.sp),
                              SizedBox(width: 8.w),
                              RichText(
                                  text: TextSpan(
                                      text:
                                          "Once accepted, you’ll confirm the transfer to their\ndemat account ",
                                      style: TextStyle(
                                        color: const Color((0xffC9CACC)),
                                        fontSize: 11.sp,
                                      ),
                                      children: [
                                    TextSpan(
                                        text: "Learn more",
                                        style: TextStyle(
                                            color: const Color((0xffc9cacc)),
                                            fontSize: 13.sp,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600))
                                  ]))
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: constWidgets.greenButton("Gift"),
        ));
  }
}
