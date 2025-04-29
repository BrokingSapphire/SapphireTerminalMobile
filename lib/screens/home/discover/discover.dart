import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/ChangePinScreen.dart';
import 'package:sapphire/screens/accountSection/SettingsScreen.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/ledgerScreen.dart';
import 'package:sapphire/screens/accountSection/profileScreen.dart';
import 'package:sapphire/screens/accountSection/profitAndLoss.dart';
import 'package:sapphire/screens/accountSection/tradesAndCharges.dart';
import 'package:sapphire/screens/home/discover/auction.dart';
import 'package:sapphire/screens/home/discover/governmentSecurities.dart';
import 'package:sapphire/screens/home/discover/ipo.dart';
import 'package:sapphire/screens/home/discover/pledge.dart';
import 'package:sapphire/screens/home/orders/alertScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';
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
              elevation: 0, // Remove shadow
              surfaceTintColor:
                  Colors.black, // Prevent grey overlay (for Material 3)
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svgs/ipo.svg',
                            width: 36.w,
                            height: 36.h,
                            color: Colors.white,
                          ),
                          title: Text(
                            'IPO',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Apply for upcoming IPOs seamlessly and stay ahead in the market.',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              size: 15.sp),
                          onTap: () {
                            navi(IPO(), context);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xff2f2f2f),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svgs/pledge.svg',
                            width: 36.w,
                            height: 36.h,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Pledge',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Pledge your holdings instantly to unlock margin for trading opportunities.',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              size: 15.sp),
                          onTap: () {
                            navi(Pledge(), context);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xff2f2f2f),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svgs/landmark.svg',
                            width: 36.w,
                            height: 36.h,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Goverment Securities',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Invest in secure government securities and earn steady, reliable returns.',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              size: 15.sp),
                          onTap: () {
                            navi(GovernmentSecurities(), context);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xff2f2f2f),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svgs/auctions.svg',
                            width: 36.w,
                            height: 36.h,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Auctions',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Access primary market auctions and invest at competitive market-discovered rates.',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              size: 15.sp),
                          onTap: () {
                            navi(Auction(), context);
                            // navi(FundsScreen(), context);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xff2f2f2f),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svgs/priceAlerts.svg',
                            width: 36.w,
                            height: 36.h,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Price Alerts',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Set custom stock alerts and stay informed on key changes instantly.',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              size: 15.sp),
                          onTap: () => navi(alertScreen(), context),
                        ),
                      ],
                    ),
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
