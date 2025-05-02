import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/general/changePin.dart';
import 'package:sapphire/screens/account/general/settings.dart';
import 'package:sapphire/screens/account/profile/profile.dart';
import 'package:sapphire/screens/account/manage/dematAccount.dart';
import 'package:sapphire/screens/funds/funds.dart';
import 'package:sapphire/screens/account/reports/ledger.dart';
import 'package:sapphire/screens/account/manage/segmentActivation.dart';
import 'package:sapphire/screens/account/manage/bankAccounts.dart';
import 'package:sapphire/screens/account/manage/freezeDematAccount.dart';
import 'package:sapphire/screens/account/manage/giftStocks.dart';
import 'package:sapphire/screens/account/reports/profitAndLoss.dart';
import 'package:sapphire/screens/account/others/referAFriend.dart';
import 'package:sapphire/screens/account/reports/orderBook.dart';
import 'package:sapphire/screens/account/reports/tradeBook.dart';
import 'package:sapphire/screens/account/reports/tradesAndCharges.dart';
import 'package:sapphire/screens/account/reports/verifiedP&L.dart';
import 'package:sapphire/screens/auth/login/login.dart';

import '../../utils/constWidgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<VoidCallback> generalOnTap;
  late List<VoidCallback> reportsOnTap;
  late List<VoidCallback> supportOnTap;
  late List<VoidCallback> othersOnTap;
  late List<VoidCallback> manageOnTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generalOnTap = [
      // () {
      //   navi(FundsScreen(), context);
      // },
      () {},
      () {
        navi(settingsScreen(), context);
      },
      () {
        navi(changePinScreen(), context);
      },
      () {
        onTapSwitchAccount();
      },
      () {
        _showLogoutDialog(context);
      }
    ];
    manageOnTap = [
      () {
        navi(GiftStocks(), context);
      },
      () {
        navi(ActiveSegments(), context);
      },
      () {
        navi(BankAccounts(), context);
      },
      () {
        navi(DematAccountDetails(), context);

        // navi(GiftStocks(), context);
      },
      () {},
      () {
        // navi(Mtf(), context);
      },
      () {
        navi(FreezeAccount(), context);
      }
    ];
    reportsOnTap = [
      () {
        navi(LedgerScreen(), context);
      },
      () {
        navi(Orderbook(), context);
      },
      () {
        navi(Tradebook(), context);
      },
      () {
        // navi(Tradebook(), context);
      },
      () {
        navi(Tradesandcharges(), context);
      },
      () {
        // navi(TaxPnl(), context);
      },
      () {
        navi(VerifiedPnL(), context);
      },
      () {
        // navi(Downloads(), context);
      }
    ];
    supportOnTap = [() {}, () {}, () {}, () {}];
    othersOnTap = [
      () {
        navi(ReferAFriend(), context);
      },
      () {}
    ];
  }

  List general = [
    "Know your Partner",
    "Settings",
    "Change PIN",
    "Switch account",
    "Logout"
  ];

  List generalSvg = [
    "assets/svgs/knowYourPartner.svg",
    "assets/svgs/settings.svg",
    "assets/svgs/changePin.svg",
    "assets/svgs/switchAccountThree.svg",
    "assets/svgs/logout.svg"
  ];

  List manage = [
    "Gift Stocks",
    "Segment Activation",
    "Bank Accounts",
    "Demat Account",
    "MTF",
    "Fund Settlement Frequency",
    "Freeze Demat Account",
  ];
  List manageSvg = [
    "assets/svgs/giftStocks.svg",
    "assets/svgs/segmentActivation.svg",
    "assets/svgs/bankAccounts.svg",
    "assets/svgs/dematAccountDetails.svg",
    "assets/svgs/mtf.svg",
    "assets/svgs/fundSettelmentFrequency.svg",
    "assets/svgs/freezeDematAccount.svg"
  ];
  List reports = [
    "Ledger",
    "Orderbook",
    "Tradebook",
    "Profit & Loss",
    "Trades & Charges",
    "Tax P&L",
    "Verified P&L",
    "Downloads"
  ];
  List reportsSvg = [
    "assets/svgs/ledger.svg",
    "assets/svgs/orderBook.svg",
    "assets/svgs/tradeBook.svg",
    "assets/svgs/profitAndLoss.svg",
    "assets/svgs/tradesAndCharges.svg",
    "assets/svgs/taxP&L.svg",
    "assets/svgs/verifiedP&L.svg",
    "assets/svgs/downloads.svg"
  ];
  List support = ["Contact Us", "App Manual", "Support Portal", "Rate our App"];
  List supportSvg = [
    "assets/svgs/contactUs.svg",
    "assets/svgs/appManual.svg",
    "assets/svgs/supportPortal.svg",
    "assets/svgs/rateOurApp.svg"
  ];
  List others = ["Refer a Friend", "Corporate Details"];
  List othersSvg = [
    "assets/svgs/referAFriend.svg",
    "assets/svgs/corporateDetails.svg"
  ];
  void onTapSwitchAccount() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26.r),
        ),
      ),
      isScrollControlled: true, // Allows content to take full height if needed
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                "Switch Account",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 7.h),
              Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
              SizedBox(height: 11.h),

              // Scrollable Account List
              SizedBox(
                // height: 300.h,
                // Adjust height as needed

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAccountTile(
                          "NK", "Nakul Pratap Thakur", "AA0000", true, isDark),
                      SizedBox(height: 16.h),
                      _buildAccountTile("PT", "Pratap Chandrakant Thakur",
                          "CJ8292", false, isDark),
                      SizedBox(height: 16.h),
                      _buildAccountTile("NC", "Nirankar Cotttex Pvt. Ltd.",
                          "JQ8749", false, isDark),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Fixed "+ Add Account" Button
              InkWell(
                onTap: () {
                  navi(LoginScreen(), context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                        color: isDark
                            ? const Color(0xff2F2F2F)
                            : const Color(0xffD1D5DB)),
                  ),
                  height: 70.h,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: isDark ? Colors.white : Colors.black,
                          size: 24.sp,
                        ),
                        Text(
                          " Add account",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Logout",
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Text(
                "Do you really want to log out?",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Color(0xff6B7280),
                  fontSize: 15.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: () {
                  // Logout logic here
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("Log out",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xff121413)
                      : const Color(0xffF4F4F9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: isDark
                            ? const Color(0xff2F2F2F)
                            : const Color(0xffD1D5DB)),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp)),
              ),
              SizedBox(height: 8.h), // Bottom padding for safe area
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountTile(
      String initials, String name, String id, bool isSelected, bool isDark) {
    return Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xff2f2f2f)),
        color: isSelected
            ? (isDark ? const Color(0xff121413) : Colors.green.withOpacity(0.2))
            : Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isDark
                  ? const Color(0xff021814)
                  : Colors.green.withOpacity(0.2),
              radius: 30.r,
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff22A06B),
                ),
              ),
            ),
            SizedBox(width: 12.w), // Spacing between avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  id,
                  style: TextStyle(
                    color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Spacer(), // Pushes the icon to the right
            CustomRadioButton(
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
            ),
            SizedBox(width: 12.w), // Padding on the right side
          ],
        ),
      ),
    );
  }

  Widget cardWithTitle(String title, List list, List<VoidCallback> OnTap,
      List logos, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Container(
                    height: 34.h,
                    width: 2.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(1.r),
                        bottomRight: Radius.circular(1.r),
                      ),
                      color: Color(0xff1DB954),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  children: List.generate(list.length, (int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: InkWell(
                        onTap: OnTap[
                            index], // Ensure OnTap[index] is correctly defined
                        child: Row(
                          children: [
                            // Leading Icon
                            Row(
                              children: [
                                SvgPicture.asset(
                                  logos[index],
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                // Title Text
                                Text(
                                  list[
                                      index], // Assuming list[index] is the list of text values
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black),
                                ),
                              ],
                            ),

                            // Spacer for the empty space between the elements
                            Expanded(
                              child:
                                  Container(), // Fills the space between the icon and the arrow
                            ),

                            // Trailing Icon
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index != list.length - 1)
                      Divider(
                        color: Color(0xff2F2F2F),
                      )
                  ],
                );
              })),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDark ? const Color(0xff000000) : Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // Pinned AppBar
            Theme(
              data: Theme.of(context).copyWith(
                appBarTheme: AppBarTheme(
                  backgroundColor:
                      isDark ? const Color(0xff000000) : Colors.white,
                  foregroundColor: isDark ? Colors.white : Colors.black,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  iconTheme: IconThemeData(
                      color: isDark ? Colors.white : Colors.black),
                  titleTextStyle: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: SliverAppBar(
                pinned: true,
                backgroundColor:
                    isDark ? const Color(0xff000000) : Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                automaticallyImplyLeading: false,
                toolbarHeight: 60.h,
                leadingWidth: 32.w,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 22.r,
                    ),
                  )
                ],
              ),
            ),
            // Pinned Divider
            SliverPersistentHeader(
              pinned: true,
              delegate: _PinnedDividerDelegate(isDark: isDark),
              floating: false,
            ),

            // Profile card as scrollable
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
                child: GestureDetector(
                  onTap: () {
                    navi(AccountScreen(), context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: isDark
                          ? const Color(0xff121413)
                          : const Color(0xFFF4F4F9),
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: isDark
                              ? const Color(0xff021814)
                              : Colors.green.withOpacity(0.2),
                          child: Text(
                            "NK",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff22A06B),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Nakul Pratap Thakur",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "AA0000",
                              style: TextStyle(
                                color: isDark
                                    ? Color(0xffC9CACC)
                                    : Color(0xff6B7280),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: isDark ? Color(0xffC9CACC) : Colors.black,
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      cardWithTitle(
                          'General', general, generalOnTap, generalSvg, isDark),
                      SizedBox(height: 12.h),
                      cardWithTitle(
                          "Manage", manage, manageOnTap, manageSvg, isDark),
                      SizedBox(height: 12.h),
                      cardWithTitle(
                          "Reports", reports, reportsOnTap, reportsSvg, isDark),
                      SizedBox(height: 12.h),
                      cardWithTitle(
                          "Support", support, supportOnTap, supportSvg, isDark),
                      SizedBox(height: 12.h),
                      cardWithTitle(
                          "Others", others, othersOnTap, othersSvg, isDark),
                      SizedBox(height: 20.h),
                      Text(
                        "© 2025 Sapphire Broking. All rights reserved. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX Registered Office: [Address], Nagpur, Maharashtra, India Email: support@sapphirebroking.com | Phone: +91 XXXXXXXXXX. Investments in securities markets are subject to market risks. Read all scheme-related documents carefully before investing. All disputes subject to Nagpur jurisdiction.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xff9B9B9B)),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.twitter,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.linkedin,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.instagram,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.youtube,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.whatsapp,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.telegram,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                          SizedBox(width: 10.w),
                          FaIcon(FontAwesomeIcons.facebook,
                              size: 18.sp, color: Color(0xff9B9B9B)),
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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

// Pinned Divider Delegate for AppBar
class _PinnedDividerDelegate extends SliverPersistentHeaderDelegate {
  final bool isDark;
  _PinnedDividerDelegate({required this.isDark});

  @override
  double get minExtent => 1.0;
  @override
  double get maxExtent => 1.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // To change the divider color below the Account section app bar, modify the color value below:
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
      height: 1.0,
      width: double.infinity,
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedDividerDelegate oldDelegate) =>
      oldDelegate.isDark != isDark;
}

// Profile Header Delegate for Pinned Profile Card
class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 80.h; // Height of the pinned profile card
  @override
  double get maxExtent => 80.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () {
          navi(AccountScreen(), context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: isDark ? const Color(0xff121413) : const Color(0xFFF4F4F9),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          // Background color for the card
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    isDark ? Color(0xff021814) : Colors.green.withOpacity(0.2),
                radius: 35.r,
                child: Text(
                  "NK",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Color(0xff22A06B) : Color(0xff22A06B),
                  ),
                ),
              ),
              SizedBox(width: 12.w), // Spacing between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nakul Pratap Thakur",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "J098WE",
                    style: TextStyle(
                      color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(), // Pushes the icon to the right
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: isDark ? Color(0xffC9CACC) : Colors.black,
                size: 20.sp,
              ),
              SizedBox(width: 12.w), // Padding on the right side
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
