import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/ChangePinScreen.dart';
import 'package:sapphire/screens/accountSection/SettingsScreen.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/ledgerScreen.dart';
import 'package:sapphire/screens/accountSection/profitAndLoss.dart';
import 'package:sapphire/screens/accountSection/tradesAndCharges.dart';

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
        // navi(SegmentActivation(), context);
      },
      () {
        // navi(BankAccounts(), context);
      },
      () {
        // navi(FundSettlementFrequency(), context);
      },
      () {
        // navi(GiftStocks(), context);
      },
      () {
        // navi(DematAccount(), context);
      },
      () {
        // navi(MTF(), context);
      },
      () {
        // navi(FreezeDematAccount(), context);
      }
    ];
    reportsOnTap = [
      () {
        navi(LedgerScreen(), context);
      },
      () {
        // navi(Tradebook(), context);
      },
      () {},
      () {
        navi(ProfitAndLoss(), context);
      },
      () {
        navi(Tradesandcharges(), context);
      },
      () {
        // navi(TaxPnl(), context);
      },
      () {},
      () {
        // navi(Downloads(), context);
      }
    ];
    supportOnTap = [() {}, () {}, () {}, () {}];
    othersOnTap = [() {}, () {}];
  }

  List general = [
    "Know your Partner",
    "Settings",
    "Change PIN",
    "Switch account",
    "Logout"
  ];

  List generalSvg = [
    "assets/svgs/funds.svg",
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
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 7.h),
              Divider(color: Color(0xff2F2F2F)),
              SizedBox(height: 11.h),

              // Scrollable Account List
              SizedBox(
                height: 200.h,
                // Adjust height as needed

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAccountTile(
                          "NK", "Nakul Pratap Thakur", "AA0000", true),
                      SizedBox(height: 16.h),
                      _buildAccountTile(
                          "PT", "Pratap Chandrakant Thakur", "CJ8292", false),
                      SizedBox(height: 16.h),
                      _buildAccountTile(
                          "NC", "Nirankar Cotttex Pvt. Ltd.", "JQ8749", false),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Fixed "+ Add Account" Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff2F2F2F)),
                ),
                height: 70.h,
                child: Center(
                  child: Text(
                    "+ Add account",
                    style: TextStyle(fontSize: 17.sp),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xff121413),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 11.h),
                Text(
                  "Do you really want to log out?",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 45.h), // Increased width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text("Log out", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff121413),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xff2F2F2F)),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    minimumSize: Size(double.infinity, 45.h), // Increased width
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountTile(
      String initials, String name, String id, bool isSelected) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Color(0xff2F2F2F))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff021814),
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  id,
                  style: TextStyle(
                    color: Color(0xffC9CACC),
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

  Widget cardWithTitle(
      String title, List list, List<VoidCallback> OnTap, List logos) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff121413), borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
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
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
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
                                  color: Colors.white,
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
                                      fontSize: 16.sp, color: Colors.white),
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xff000000),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                // AppBar title as scrollable
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffEBEEF5),
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 22.r,
                          ),
                        ]),
                  ),
                ),

                // Market Cards (NIFTY, SENSEX)

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ProfileHeaderDelegate(),
                )
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          SizedBox(height: 10.h),
                          cardWithTitle(
                              'General', general, generalOnTap, generalSvg),
                          SizedBox(height: 10.h),
                          cardWithTitle(
                              "Manage", manage, manageOnTap, manageSvg),
                          SizedBox(height: 10.h),
                          cardWithTitle(
                              "Reports", reports, reportsOnTap, reportsSvg),
                          SizedBox(height: 10.h),
                          cardWithTitle(
                              "Support", support, supportOnTap, supportSvg),
                          SizedBox(height: 10.h),
                          cardWithTitle(
                              "Others", others, othersOnTap, othersSvg),
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
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.linkedin,
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.instagram,
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.youtube,
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.whatsapp,
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.telegram,
                                  color: Color(0xff9B9B9B)),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.facebook,
                                  color: Color(0xff9B9B9B)),
                            ],
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ],
                ),
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

// Profile Header Delegate for Pinned Profile Card
class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 80.h; // Height of the pinned profile card
  @override
  double get maxExtent => 80.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xff121413),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        // Background color for the card
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff021814),
              radius: 35.r,
              child: Text(
                "NK",
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
                  "Nakul Pratap Thakur",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "J098WE",
                  style: TextStyle(
                    color: Color(0xffC9CACC),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Spacer(), // Pushes the icon to the right
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color(0xffC9CACC),
              size: 20.sp,
            ),
            SizedBox(width: 12.w), // Padding on the right side
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
