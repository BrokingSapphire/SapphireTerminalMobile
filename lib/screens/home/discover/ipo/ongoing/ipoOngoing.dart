import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/ipo/applied/ipoApplicationStatus.dart';
import 'package:sapphire/screens/home/discover/ipo/ongoing/ipoApply.dart';
import 'package:sapphire/utils/ipoTile.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart'; // Assuming this file contains your custom widgets

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
        body: Column(children: [
      SizedBox(height: 8.h),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  height: 400.h, // adjust as needed
                  child: TabBarView(
                    children: [
                      // Ongoing Tab
                      RefreshIndicator(
                        onRefresh: () async {
                          // TODO: Add your refresh logic here
                        },
                        color: Color(0xff1db954),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {},
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
                                  naviWithoutAnimation(context, IPOApply());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ]));
  }
}
