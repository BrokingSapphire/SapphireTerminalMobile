import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/funds/funds.dart';
import 'package:sapphire/screens/account/account.dart';
import 'package:sapphire/screens/home/holdings/mutualFunds/mutualFunds.dart';
import 'package:sapphire/screens/home/holdings/positions/positions.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';
import 'equity/equity.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({super.key});

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  late PageController _pageController;
  final List<String> tabs = ["Equity", "Positions", "Mutual Funds"];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Instant switch for taps
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index; // Update tab bar instantly on swipe
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Holdings",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () {
                              naviWithoutAnimation(context, FundsScreen());
                            },
                            child: SvgPicture.asset("assets/svgs/wallet.svg",
                                width: 20.w, height: 23.h, color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navi(const ProfileScreen(), context);
                          },
                          child: CircleAvatar(
                            backgroundColor: isDark
                                ? Color(0xff021814)
                                : Color(0xff22A06B).withOpacity(0.2),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      marketDataCard(
                          "NIFTY 50", "23,018.20", "-218.20 (1.29%)", isDark),
                      marketDataCard(
                          "SENSEX", "73,018.20", "+218.20 (1.29%)", isDark),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomTabBarDelegate(
                  tabNames: tabs,
                  selectedIndex: _selectedIndex,
                  onTabTapped: _onTabTapped,
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const EquityScreen();
                  case 1:
                    return const positionScreen();
                  case 2:
                    return const MutualFundsScreen();
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabTapped;

  CustomTabBarDelegate({
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  double get minExtent => 35.h;

  @override
  double get maxExtent => 55.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              color: const Color(0xff2f2f2f),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(tabNames.length, (index) {
            final isSelected = index == selectedIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabTapped(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? const Color(0xff1DB954)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        tabNames[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.green
                              : isDark
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ]),
    );
  }

  @override
  bool shouldRebuild(covariant CustomTabBarDelegate oldDelegate) {
    return tabNames != oldDelegate.tabNames ||
        selectedIndex != oldDelegate.selectedIndex;
  }
}

Widget marketDataCard(String title, String price, String change, bool isDark) {
  final bool isPositive = change.startsWith('+');
  final Color changeColor = isPositive ? Colors.green : Colors.red;
  return Container(
    height: 62.h,
    width: 175.w,
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: isDark ? const Color(0xff121413) : const Color(0xFFF4F4F9),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
          color: isDark ? const Color(0xff2F2F2F) : const Color(0xFFF4F4F9),
          width: 1.5.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: isDark ? const Color(0xffEBEEF5) : Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff121413) : Color(0xFFF4F4F9),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                price,
                style: TextStyle(
                    color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                    fontSize: 12.sp),
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
