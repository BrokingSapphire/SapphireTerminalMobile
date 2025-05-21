import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/discover/ipo/applied/ipoApplied.dart';
import 'package:sapphire/screens/home/discover/ipo/ongoing/ipoOngoing.dart';
import 'package:sapphire/screens/home/discover/ipo/upcoming/ipoUpcoming.dart';

class IPOWrapper extends StatefulWidget {
  const IPOWrapper({Key? key}) : super(key: key);

  @override
  State<IPOWrapper> createState() => _IPOWrapperState();
}

class _IPOWrapperState extends State<IPOWrapper> {
  late PageController _pageController;
  final List<String> tabs = ["Ongoing", "Applied", "Upcoming"];
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: isDark ? Colors.black : Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              pinned: true,
              leadingWidth: 24.w,
              title: Text(
                "IPO",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black,
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
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return ongoingIpo();
              case 1:
                return appliedIpo();
              case 2:
                return upcomingIpo();
              default:
                return const SizedBox.shrink();
            }
          },
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
