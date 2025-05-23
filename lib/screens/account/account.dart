import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/general/changePin/changePin.dart';
import 'package:sapphire/screens/account/general/knowYourPartner/knowYourPartner.dart';
import 'package:sapphire/screens/account/general/settings/settings.dart';
import 'package:sapphire/screens/account/manage/fundSettelmentFrequency/fundSettelmentFrequency.dart';
import 'package:sapphire/screens/account/profile/profile.dart';
import 'package:sapphire/screens/account/manage/dematAccount/dematAccount.dart';
import 'package:sapphire/utils/customCalender.dart';
import 'package:sapphire/screens/account/reports/ledger/ledger.dart';
import 'package:sapphire/screens/account/manage/segmentActivation/segmentActivation.dart';
import 'package:sapphire/screens/account/manage/bankAccounts/bankAccounts.dart';
import 'package:sapphire/screens/account/manage/freezeDematAccount/freezeDematAccount.dart';
import 'package:sapphire/screens/account/manage/giftStocks/giftStocks.dart';
import 'package:sapphire/screens/account/reports/profitAndLoss/profitAndLoss.dart';
import 'package:sapphire/screens/account/others/referAFriend/referAFriend.dart';
import 'package:sapphire/screens/account/reports/orderBook/orderBook.dart';
import 'package:sapphire/screens/account/reports/tradeBook/tradeBook.dart';
import 'package:sapphire/screens/account/reports/tradesAndCharges/tradesAndCharges.dart';
import 'package:sapphire/screens/account/reports/verifiedP&L/verifiedP&L.dart';
import 'package:sapphire/screens/auth/login/login.dart';
import 'package:sapphire/utils/webviewScreen.dart';

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
    super.initState();
    generalOnTap = [
      () {
        navi(KnowYourPartner(), context);
      },
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
      () {
        // navi(Mtf(), context);
        navi(fundSettelmentFrequency(), context);
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
        navi(ProfitAndLoss(), context);
      },
      () {
        navi(Tradesandcharges(), context);
      },
      () {
        showTaxPnlSheet(context);
      },
      () {
        navi(VerifiedPnL(), context);
      },
      () {
        showDownloadSheet(context);
      }
    ];
    supportOnTap = [
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: 'https://www.sapphirebroking.com/contact',
              title: 'Contact Us',
            ),
          ),
        );
      },
      () {},
      () {},
      () {}
    ];
    othersOnTap = [
      () {
        navi(ReferAFriend(), context);
      },
    ];
  }

  DateTimeRange? _selectedDateRange;

  Future<void> _showCustomDateRangePicker() async {
    final DateTimeRange? picked = await showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => CustomDateRangePickerBottomSheet(
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDateRange: _selectedDateRange,
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void showTaxPnlSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        // List to track the selected state of each chip
        List<bool> selectedChips =
            List.generate(6, (_) => false); // 6 chips in total

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Helper function to handle chip selection
            void onChipSelected(int index) {
              setState(() {
                // Deselect all chips
                for (int i = 0; i < selectedChips.length; i++) {
                  selectedChips[i] = false;
                }
                // Select the tapped chip
                selectedChips[index] = true;
              });
            }

            return Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff121413) : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Download Tax P&L",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    height: 1,
                    color: isDark
                        ? const Color(0xff2F2F2F)
                        : const Color(0xffD1D5DB),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Select a Financial Year",
                    softWrap: true,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onChipSelected(0),
                        child: constWidgets.choiceChip(
                          "FY 2025-26",
                          selectedChips[0],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onChipSelected(1),
                        child: constWidgets.choiceChip(
                          "FY 2024-25",
                          selectedChips[1],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onChipSelected(2),
                        child: constWidgets.choiceChip(
                          "FY 2023-24",
                          selectedChips[2],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onChipSelected(3),
                        child: constWidgets.choiceChip(
                          "FY 2022-23",
                          selectedChips[3],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onChipSelected(4),
                        child: constWidgets.choiceChip(
                          "FY 2021-22",
                          selectedChips[4],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onChipSelected(5),
                        child: constWidgets.choiceChip(
                          "FY 2020-21",
                          selectedChips[5],
                          context,
                          104.w,
                          isDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  constWidgets.greenButton(
                    "Download",
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showDownloadSheet(BuildContext context) {
    String selectedSegment = 'Equity'; // Default selected value
    String selectedReportType = 'PDF'; // Default selected value
    DateTimeRange? dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Downloads Statements",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                      height: 1,
                      color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
                  SizedBox(height: 16.h),
                  Text("Statement",
                      softWrap: true,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 40.h,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        hintText: 'Equity',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 10.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w), // Remove default padding
                      ),
                      dropdownColor:
                          isDark ? Colors.grey.shade800 : Color(0xffF4F4F9),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      value: selectedSegment,
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Equity', 'Futures', 'Options']
                            .map<Widget>(
                          (String value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp,
                                ),
                                softWrap: true,
                              ),
                            );
                          },
                        ).toList();
                      },
                      items: <String>['Equity', 'Futures', 'Options']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 13.sp),
                            softWrap: true,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedSegment = newValue;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Report Type',
                    softWrap: true,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 40.h,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        hintText: 'XLSX',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 10.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w), // Remove default padding
                      ),
                      dropdownColor:
                          isDark ? Colors.grey.shade800 : Color(0xffF4F4F9),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      value: selectedReportType,
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['PDF', 'XLSX'].map<Widget>(
                          (String value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp,
                                ),
                                softWrap: true,
                              ),
                            );
                          },
                        ).toList();
                      },
                      items: <String>['PDF', 'XLSX']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 13.sp),
                            softWrap: true,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedReportType = newValue;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Date range',
                    softWrap: true,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () async {
                      _showCustomDateRangePicker();
                    },
                    child: Container(
                      height: 40.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${DateFormat('dd-MM-yyyy').format(dateRange.start)} ~ ${DateFormat('dd-MM-yyyy').format(dateRange.end)}',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black,
                          fontSize: 13.sp,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  constWidgets.greenButton(
                    "Download",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
    "Fund Settlement Frequency",
    "Freeze Demat Account",
  ];
  List manageSvg = [
    "assets/svgs/giftStocks.svg",
    "assets/svgs/segmentActivation.svg",
    "assets/svgs/bankAccounts.svg",
    "assets/svgs/dematAccountDetails.svg",
    "assets/svgs/fundSettelmentFrequency.svg",
    "assets/svgs/freezeDematAccount.svg"
  ];
  List reports = [
    "Ledger",
    "Orderbook",
    "Tradebook",
    "Profit And Loss",
    "Trades And Charges",
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
  List others = ["Refer a Friend"];
  List othersSvg = [
    "assets/svgs/referAFriend.svg",
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
      isScrollControlled: true,
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
                                  list[index],
                                  // Assuming list[index] is the list of text values
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
                    fontSize: 17.sp,
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
                    fontSize: 17.sp,
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
