import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/discover/discover.dart';
import 'package:sapphire/screens/home/orders/orderSection.dart';
import 'package:sapphire/screens/home/trades/tradesScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'discover/accountsScreen.dart';
import 'holdings/holdingsScreen.dart';
import 'orders/createGttScreen.dart';
import 'orders/gttScreenWrapper.dart';
import 'watchlist/watchlistScreen.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main App Content
        Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: [
              const WatchlistScreen(),
               OrderSection(),
              const HoldingsScreen(),
              const TradesScreen(),
              const DiscoverScreen(),
            ],
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFF2C2C2E),
                ),
                BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  selectedItemColor: const Color(0xff1DB954),
                  unselectedItemColor: const Color(0xff959595),
                  backgroundColor: const Color(0xFF020202),
                  type: BottomNavigationBarType.fixed,
                  onTap: _onItemTapped,
                  selectedLabelStyle: TextStyle(fontSize: 13.sp),
                  unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                  items: [
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        // height: 34.h, // 👈 increase height here
                        child: SvgPicture.asset(
                          "assets/svgs/Home.svg",
                          width: 22.w,
                          height: 25.h,
                          color: _selectedIndex == 0
                              ? const Color(0xff1DB954)
                              : const Color(0xff959595),
                        ),
                      ),
                      label: 'Watchlist',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        // height: 34.h,
                        child: SvgPicture.asset(
                          "assets/svgs/order.svg",
                          width: 22.w,
                          height: 25.h,
                          color: _selectedIndex == 1
                              ? const Color(0xff1DB954)
                              : const Color(0xff959595),
                        ),
                      ),
                      label: 'Order',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        // height: 34.h,
                        child: SvgPicture.asset(
                          "assets/svgs/holdings.svg",
                          width: 22.w,
                          height: 25.h,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 2
                                ? const Color(0xff1DB954)
                                : const Color(0xff959595),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      label: 'Holdings',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        // height: 34.h,
                        child: SvgPicture.asset(
                          "assets/svgs/trades.svg",
                          width: 22.w,
                          height: 25.h,
                          color: _selectedIndex == 3
                              ? const Color(0xff1DB954)
                              : const Color(0xff959595),
                        ),
                      ),
                      label: 'Trades',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        // height: 34.h,
                        child: SvgPicture.asset(
                          "assets/svgs/discover.svg",
                          width: 22.w,
                          height: 25.h,
                          color: _selectedIndex == 4
                              ? const Color(0xff1DB954)
                              : const Color(0xff959595),
                        ),
                      ),
                      label: 'Discover',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
