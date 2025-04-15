import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/profileScreen.dart';
import 'package:sapphire/screens/home/trades/tradeReuse.dart';
import 'package:sapphire/screens/home/trades/stock/tradesActiveScreen.dart';
import 'package:sapphire/screens/home/trades/stock/tradesClosedScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';
import '../holdings/holdingsScreen.dart';

class TradesScreen extends StatefulWidget {
  const TradesScreen({super.key});

  @override
  State<TradesScreen> createState() => _TradesScreenState();
}

class _TradesScreenState extends State<TradesScreen> {
  late PageController _pageController;
  final List<String> tabs = ["Stock", "Futures", "Options", "Commodity"];
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
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          automaticallyImplyLeading: false, // ✅ As requested
          toolbarHeight: 0, // Hides visible AppBar but keeps safe area layout
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // AppBar title as scrollable
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trades",
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
                          naviWithoutAnimation(context, ProfileScreen());
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

            // Market Cards scroll away
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MarketDataCard("NIFTY 50", "23,018.20", "-218.20 (1.29%)"),
                    MarketDataCard("SENSEX", "73,018.20", "+218.20 (1.29%)"),
                  ],
                ),
              ),
            ),

            // Sticky Custom Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomTabBarDelegate(
                tabNames: tabs,
                selectedIndex: _selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ),
          ],
          body: SingleChildScrollView(
            // Added to handle overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        100.h, // Adjust based on header height
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return TradesTabContent(tabType: tabs[index]);
                      },
                    ),
                  ),
                ),
              ],
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
  double get minExtent => 55.h;
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
                style:
                    TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp),
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
