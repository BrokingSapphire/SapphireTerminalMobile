import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/profileScreen.dart';
import 'package:sapphire/screens/home/holdings/mutualFunds/mutualScreen.dart';
import 'package:sapphire/screens/home/holdings/positions/position.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'equity/equityScreen.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Holdings",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffEBEEF5),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () {
                              navi(FundsScreen(), context);
                            },
                            child: SvgPicture.asset(
                              "assets/svgs/wallet.svg",
                              width: 22.w,
                              height: 25.h,
                              color: Colors.white70,
                            ),
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
                        )
                      ]),
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
    return Container(
      color: const Color(0xff000000),
      child: Row(
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
                        color: isSelected ? Colors.green : Colors.white,
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
    );
  }

  @override
  bool shouldRebuild(covariant CustomTabBarDelegate oldDelegate) {
    return tabNames != oldDelegate.tabNames ||
        selectedIndex != oldDelegate.selectedIndex;
  }
}
