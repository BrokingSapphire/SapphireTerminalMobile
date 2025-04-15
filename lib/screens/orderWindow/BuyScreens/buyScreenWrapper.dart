import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/screens/home/orders/gttScreenWrapper.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/IcebergBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/InstantBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/MTFBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/NormalBuyScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';

class BuyScreenWrapper extends StatefulWidget {
  final bool isbuy;
  BuyScreenWrapper({Key? key, required this.isbuy}) : super(key: key);
  @override
  _BuyScreenWrapperState createState() => _BuyScreenWrapperState();
}

class _BuyScreenWrapperState extends State<BuyScreenWrapper>
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
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: CustomTabBar(tabController: _tabController, options: list),
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
                    NormalBuyScreen("Normal"),
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
                    color: widget.isbuy ? Color(0xff1db954) : Colors.red,
                    size: 22,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              HoldableButton(
                width: double.infinity,
                height: 54.h,
                loadingType: LoadingType.fillingLoading,
                buttonColor: widget.isbuy ? Color(0xff1db954) : Colors.red,
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
                    color: widget.isbuy ? Color(0xff1db954) : Colors.red,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      "Hold to ${widget.isbuy ? "Buy" : "Sell"}",
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
