import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/orders/gttOrder/createGTT.dart';
import '../../../../utils/constWidgets.dart';

class gtt3Screen extends StatefulWidget {
  const gtt3Screen({super.key});

  @override
  State<gtt3Screen> createState() => _gtt3ScreenState();
}

class _gtt3ScreenState extends State<gtt3Screen> {
  TextEditingController mybasketname = TextEditingController();
  final List<Map<String, dynamic>> stocks = [
    {
      "name": "RELIANCE",
      "date": "Reliance Industries Ltd.",
      "type": "cash",
      "image":
          "assets/images/reliance logo.png", // Replace with actual image path
    },
    {
      "name": "RELIANCE FUT",
      "date": "27 Mar 2025",
      "type": "future",
      "image":
          "assets/images/reliance logo.png", // Replace with actual image path
    },
    {
      "name": "RELIANCE 1200 CE",
      "date": "27 Mar 2025",
      "type": "option",
      "image":
          "assets/images/reliance logo.png", // Replace with actual image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 38,
        title: Text("New GTT",
            style: TextStyle(color: Colors.white, fontSize: 15.sp)),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.h), // Controls the height of the divider
          child: Divider(
            color: Colors.grey.shade800, // Light grey divider for contrast
            thickness: 1, // Divider thickness
            height: 1, // Ensures it sticks to the bottom of the AppBar
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            constWidgets.searchField(context, "Search GTT", "orders", isDark),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  final stock = stocks[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navi(OrdersScreen(), context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                              // Background color
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Stock Logo/Icon
                                  CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(stock["image"]),
                                    // Load image from list
                                  ),
                                  SizedBox(width: 10.w),

                                  // Stock Name & Date
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stock["name"],
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        stock["date"],
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Color(0xffC9CACC)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Stock Type & Market
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "NSE",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    stock["type"], // Cash, Future, Option, etc.
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Color(0xffC9CACC)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index <
                          stocks.length - 1) // Show divider between items
                        Divider(color: Colors.grey.shade800, height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
