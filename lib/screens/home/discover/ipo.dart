import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart'; // Assuming this file contains your custom widgets
import '../../../utils/ipoTile.dart'; // Assuming this file contains your ipoTile widget

class IPO extends StatefulWidget {
  const IPO({super.key});

  @override
  State<IPO> createState() => _IPOState();
}

class _IPOState extends State<IPO> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List of options to display in the tab bar
  final List<String> options = ["Ongoing", "Upcoming", "Closed"];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController here
    _tabController = TabController(length: options.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "IPO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            color: const Color(0xFF2F2F2F),
          ),
          SizedBox(height: 12.h),
          // Tab bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  CustomTabBar(
                    tabController:
                        _tabController, // Pass the TabController here
                    options: options, // Pass the options here
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 400.h, // adjust as needed
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Ongoing Tab
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: Column(
                              children: [
                                ipoTile(
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
                                  onApply: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Upcoming Tab
                        Center(
                            child: Text("No Upcoming IPOs",
                                style: TextStyle(color: Colors.white))),
                        // Closed Tab
                        Center(
                            child: Text("No Closed IPOs",
                                style: TextStyle(color: Colors.white))),
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
