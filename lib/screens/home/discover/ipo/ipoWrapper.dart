import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoOngoing.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoApplied.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoClosed.dart';
import 'package:sapphire/screens/home/discover/ipo/ipoOngoing.dart';
import 'package:sapphire/utils/constWidgets.dart';

class IPOWrapper extends StatefulWidget {
  const IPOWrapper({Key? key}) : super(key: key);

  @override
  State<IPOWrapper> createState() => _IPOWrapperState();
}

class _IPOWrapperState extends State<IPOWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  // List of options to display in the tab bar
  final List<String> options = ["Ongoing", "Applied", "Upcoming"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: options.length, vsync: this);
    _pageController = PageController();

    // Listen to tab changes and update page view accordingly
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "IPO",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(68.h),
          child: Column(
            children: [
              Divider(
                height: 1,
                color:
                    isDark ? const Color(0xff2F2F2F) : const Color(0xffD1D5DB),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: CustomTabBar(
                  tabController: _tabController, // Pass the TabController here
                  options: options, // Pass the options here
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: [
          // Ongoing IPOs page - using the existing IPO widget
          ongoingIpo(),

          // Applied IPOs page - using the separate IPOApplied widget
          appliedIpo(),

          // Closed IPOs page - using the separate IPOClosed widget
          upcomingIpo(),
        ],
      ),
    );
  }
}
