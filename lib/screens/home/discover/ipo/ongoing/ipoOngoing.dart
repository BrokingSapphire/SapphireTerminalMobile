import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/ipo/applied/ipoApplicationStatus.dart';
import 'package:sapphire/screens/home/discover/ipo/ongoing/ipoApply.dart';
import 'package:sapphire/utils/ipoTile.dart'; // Assuming this file contains your custom widgets

class ongoingIpo extends StatefulWidget {
  const ongoingIpo({super.key});

  @override
  State<ongoingIpo> createState() => _ongoingIpoState();
}

class _ongoingIpoState extends State<ongoingIpo>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;

  // List of options to display in the tab bar
  // final List<String> options = ["Ongoing", "Applied", "Closed"];

  @override
  // void initState() {
  //   super.initState();
  //   // Initialize the TabController here
  //   _tabController = TabController(length: options.length, vsync: this);
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Divider(
          //   height: 1,
          //   color: const Color(0xFF2F2F2F),
          // ),
          SizedBox(height: 8.h),
          // Tab bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  // CustomTabBar(
                  //   tabController:
                  //       _tabController, // Pass the TabController here
                  //   options: options, // Pass the options here
                  // ),
                  // SizedBox(height: 6.h),
                  Container(
                    height: 400.h, // adjust as needed
                    child: TabBarView(
                      // controller: _tabController,
                      children: [
                        // Ongoing Tab
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    navi(ipoApplication(), context);
                                  },
                                  child: ipoTile(
                                    img: "assets/images/reliance logo.png",
                                    title:
                                        "Akme Fintrade India ltd. (Aasaan Loans)",
                                    closeDate: "21 June 2025",
                                    minInvestment: "1460.80",
                                    badge1: "SME",
                                    badge2: "CLOSING TODAY",
                                    description:
                                        "IIFL Finance is a Non-Banking Financial Company – Middle Layer (NBFC-ML), registered with the RBI, providing a wide range of financial products to meet the diverse credit needs of ...",
                                    statusDay: "Day 3",
                                    subscriptionStatus: "1.4x",
                                    price: "3,21,380.00",
                                    lotSize: "6,789.00",
                                    onApply: () {
                                      navi(IPOApply(), context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
