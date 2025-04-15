import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/IcebergBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/MTFBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/NormalBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/normalSellScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';

import '../BuyScreens/InstantBuyScreen.dart';

class SellScreenWrapper extends StatefulWidget {
  @override
  _SellScreenWrapperState createState() => _SellScreenWrapperState();
}

class _SellScreenWrapperState extends State<SellScreenWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isNSE = true;
  List<String> list = ["Instant", "Normal", "Iceberg", "Cover"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onSwipe(bool isLeftSwipe) {
    setState(() {
      if (isLeftSwipe && _tabController.index < _tabController.length - 1) {
        _tabController.animateTo(_tabController.index + 1);
      } else if (!isLeftSwipe && _tabController.index > 0) {
        _tabController.animateTo(_tabController.index - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBar(
              leadingWidth: 28.w,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RELIANCE",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "₹1,256.89 (+1.67%)",
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xff2F2F2F),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isNSE = true),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          height: 22.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color:
                                isNSE ? Color(0xff1db954) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              'NSE',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isNSE ? Colors.white : Color(0xffC9CACC),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: () => setState(() => isNSE = false),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          height: 22.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color:
                                !isNSE ? Color(0xff1db954) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              'BSE',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color:
                                    !isNSE ? Colors.white : Color(0xffC9CACC),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: Color(0xff2f2f2f)),
            // Container(
            //   color: Colors.black,
            //   child: TabBar(
            //     controller: _tabController,
            //     labelColor: Colors.green,
            //     unselectedLabelColor: Colors.grey,
            //     indicatorColor: Colors.green,
            //     tabs: [
            //       Tab(text: "Instant"),
            //       Tab(text: "Normal"),
            //       Tab(text: "Iceberg"),
            //       Tab(text: "Cover"),
            //     ],
            //   ),
            // ),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SellTabBar(tabController: _tabController, options: list),
            ),

            SizedBox(
              height: 14.h,
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    _onSwipe(true);
                  } else if (details.primaryVelocity! > 0) {
                    _onSwipe(false);
                  }
                },
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BuyScreenTabContent("Instant"),
                    NormalSellScreen("Normal"),
                    Icebergbuyscreen("Iceberg"),
                    MTFBuyScreen("Cover"),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Margin Required",
                        style: TextStyle(
                            fontSize: 11.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹75.68",
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Charges",
                        style: TextStyle(
                            fontSize: 11.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹75.68",
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Margin",
                        style: TextStyle(
                            fontSize: 11.sp, color: Color(0xffC9CACC)),
                      ),
                      Text(
                        "₹2,56,897.89",
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.refresh,
                    color: Color(0xffE53935),
                    size: 22,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              HoldableButton(
                width: double.infinity,
                height: 54.h,
                loadingType: LoadingType.fillingLoading,
                buttonColor: Color(0xffE53935),
                loadingColor: Colors.white,
                radius: 30.r,
                duration: 1,
                onConfirm: () {
                  print("Buy action confirmed!");
                },
                strokeWidth: 2,
                beginFillingPoint: Alignment.centerLeft,
                endFillingPoint: Alignment.centerRight,
                edgeLoadingStartPoint: 0.0,
                hasVibrate: true,
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Color(0xffE53935),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      "Hold to Sell",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SellTabBar extends StatefulWidget {
  final TabController tabController;
  final List<String> options;

  const SellTabBar(
      {required this.tabController, required this.options, Key? key})
      : super(key: key);

  @override
  _SellTabBarState createState() => _SellTabBarState();
}

class _SellTabBarState extends State<SellTabBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (mounted) setState(() {}); // Updates UI when tab changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.options.length, (index) {
              bool isSelected = widget.tabController.index == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.tabController.animateTo(index);
                  },
                  child: Column(
                    children: [
                      Text(
                        widget.options[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Color(0xffE53935)
                              : Color(0xffEBEEF5),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Green underline effect divided equally
          LayoutBuilder(
            builder: (context, constraints) {
              double segmentWidth =
                  constraints.maxWidth / widget.options.length;
              return Stack(
                children: [
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    color: Colors.transparent,
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: widget.tabController.index * segmentWidth,
                    child: Container(
                      height: 2.h,
                      width: segmentWidth,
                      color: Color(0xffE53935),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
