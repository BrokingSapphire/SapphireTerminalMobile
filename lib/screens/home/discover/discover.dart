import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/account.dart';
import 'package:sapphire/screens/funds/funds.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoWrapper.dart';
import 'package:sapphire/screens/home/discover/pledge/pledge.dart';
import 'package:sapphire/screens/home/discover/priceAlerts/priceAlerts.dart';
import 'package:sapphire/screens/optionChain/optionChain.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late List<VoidCallback> generalOnTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalOnTap = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xff000000),
            appBar: AppBar(
              elevation: 0,
              // Remove shadow
              surfaceTintColor: Colors.black,
              // Prevent grey overlay (for Material 3)
              shadowColor: Colors.transparent,
              backgroundColor: const Color(0xff000000),
              // automaticallyImplyLeading: false, // ✅ As requested
              toolbarHeight:
                  0, // Hides visible AppBar but keeps safe area layout
            ),
            body: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                // AppBar title as scrollable
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discover",
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffEBEEF5),
                            ),
                          ),
                          // _popupMenuIcon(context)
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GestureDetector(
                              onTap: () {
                                naviWithoutAnimation(context, FundsScreen());
                              },
                              child: SvgPicture.asset("assets/svgs/wallet.svg",
                                  width: 20.w,
                                  height: 23.h,
                                  color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navi(const ProfileScreen(), context);
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff021814),
                              radius: 22.r,
                              child: Text(
                                "NK",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff22A06B),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),

                // Market Card inside the AppBar
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MarketDataCard(
                            "NIFTY 50", "23,018.20", "-218.20 (1.29%)"),
                        MarketDataCard(
                            "SENSEX", "73,018.20", "+218.20 (1.29%)"),
                      ],
                    ),
                  ),
                ),
              ],
              body: Column(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xff2f2f2f),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 16.h),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        leading: SvgPicture.asset(
                          'assets/svgs/ipo.svg',
                          width: 24.w,
                          height: 24.h,
                          color: Color(0xffc9cacc),
                        ),
                        title: Text(
                          'IPO',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                        subtitle: Text(
                          'Apply for upcoming IPOs seamlessly and stay ahead in the market.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xffc9cacc),
                          ),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 15.sp),
                        onTap: () {
                          navi(IPOWrapper(), context);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xff2f2f2f),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        leading: SvgPicture.asset(
                          'assets/svgs/pledge.svg',
                          width: 24.w,
                          height: 24.h,
                          color: Color(0xffc9cacc),
                        ),
                        title: Text(
                          'Pledge',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                        subtitle: Text(
                          'Pledge your holdings instantly to unlock margin for trading opportunities.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xffc9cacc),
                          ),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 15.sp),
                        onTap: () {
                          navi(Pledge(), context);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xff2f2f2f),
                      ),
                      // Divider(
                      //   height: 1,
                      //   color: Color(0xff2f2f2f),
                      // ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        leading: SvgPicture.asset(
                          'assets/svgs/priceAlerts.svg',
                          width: 24.w,
                          height: 24.h,
                          color: Color(0xffc9cacc),
                        ),
                        title: Text(
                          'Price Alerts',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                        subtitle: Text(
                          'Set custom stock alerts and stay informed on key changes instantly.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xffc9cacc),
                          ),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 15.sp),
                        onTap: () => navi(PriceAlerts(), context),
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xff2f2f2f),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        leading: SvgPicture.asset(
                          'assets/svgs/optionChain.svg',
                          width: 24.w,
                          height: 24.h,
                          color: Color(0xffc9cacc),
                        ),
                        title: Text(
                          'Option Chain',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                        subtitle: Text(
                          'View live option chain data to analyse market sentiment instantly.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xffc9cacc),
                          ),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 15.sp),
                        onTap: () {
                          navi(
                              OptionChainWrapper(
                                  symbol: "NIFTY",
                                  exchange: "NSE",
                                  stockName: "NIFTY",
                                  price: "25019.80",
                                  change: "-42.30(0.17%)"),
                              context);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xff2f2f2f),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  // Market Card UI
  Widget MarketDataCard(String title, String price, String change) {
    final bool isPositive = change.startsWith('+');
    final Color changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      height: 62.h,
      width: 175.w,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xff121413),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xff2F2F2F), width: 1.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: const Color(0xffEBEEF5),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: const Color(0xff121413),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  price,
                  style: TextStyle(
                      color: const Color(0xffEBEEF5), fontSize: 12.sp),
                ),
                SizedBox(width: 6.w),
                Text(
                  change,
                  style: TextStyle(color: changeColor, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
