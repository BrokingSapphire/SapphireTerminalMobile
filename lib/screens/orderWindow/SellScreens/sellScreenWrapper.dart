import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/IcebergBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/MTFBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/NormalBuyScreen.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/MTFSellScreen.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/icebergSellScreen.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/instantSellScreen.dart';
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
                    SellScreenTabContent("Instant"),
                    NormalSellScreen("Normal"),
                    IcebergSellScreen("Iceberg"),
                    MTFSellScreen("Cover"),
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

class sellScreenToggle extends StatelessWidget {
  final bool isFirstOptionSelected;
  final Function(bool) onToggle;
  final String firstOption;
  final String secondOption;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color unselectedTextColor;
  final double height;
  final double borderRadius;

  const sellScreenToggle({
    Key? key,
    required this.isFirstOptionSelected,
    required this.onToggle,
    required this.firstOption,
    required this.secondOption,
    this.backgroundColor = const Color(0xff2f2f2f),
    this.selectedColor = const Color(0xffE53935),
    this.textColor = Colors.white,
    this.unselectedTextColor = const Color(0xffebeef5),
    this.height = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              // Animated selection indicator
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isFirstOptionSelected ? 0 : segmentWidth,
                top: 0,
                child: Container(
                  height: height.h,
                  width: segmentWidth,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                ),
              ),

              // Option texts
              Row(
                children: [
                  // First option (e.g., Market)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          firstOption,
                          style: TextStyle(
                            color: isFirstOptionSelected
                                ? textColor
                                : unselectedTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Second option (e.g., Limit)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onToggle(false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          secondOption,
                          style: TextStyle(
                            color: !isFirstOptionSelected
                                ? textColor
                                : unselectedTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class sellAnimatedToggle extends StatefulWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onToggle;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double height;
  final double borderRadius;

  const sellAnimatedToggle({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onToggle,
    this.backgroundColor = const Color(0xff121413),
    this.selectedBackgroundColor = const Color(0xff2f2f2f),
    this.selectedTextColor = const Color(0xffE53935),
    this.unselectedTextColor = Colors.grey,
    this.height = 40,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  State<sellAnimatedToggle> createState() => _sellAnimatedToggleState();
}

class _sellAnimatedToggleState extends State<sellAnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / widget.options.length;

          return Stack(
            children: [
              // Animated selection indicator
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: widget.selectedIndex * segmentWidth + 4,
                top: 4,
                child: Container(
                  height: widget.height.h - 8,
                  width: segmentWidth - 8,
                  decoration: BoxDecoration(
                    color: widget.selectedBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius - 4),
                  ),
                ),
              ),

              // Option texts
              Row(
                children: List.generate(widget.options.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onToggle(index),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.options[index],
                          style: TextStyle(
                            color: widget.selectedIndex == index
                                ? widget.selectedTextColor
                                : widget.unselectedTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class sellScreenCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double size;
  final double checkmarkPadding; // Padding around the checkmark

  const sellScreenCheckbox({
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.checkmarkPadding = 4.0, // Default padding around checkmark
    super.key,
  });

  @override
  State<sellScreenCheckbox> createState() => _sellScreenCheckboxState();
}

class _sellScreenCheckboxState extends State<sellScreenCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.value
                  ? Color(0xffE53935)
                  : Colors.grey
                      .shade800, // Matches 'side: BorderSide(color: Colors.grey.shade800, width: 1)'
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6
                .r), // Matches 'shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))'
            color: Colors.transparent
            // Matches 'activeColor: Colors.green' and 'fillColor: WidgetStateProperty.all(Colors.transparent)'
            ),
        child: widget.value
            ? Padding(
                padding: EdgeInsets.all(
                    widget.checkmarkPadding), // Padding around checkmark
                child: Icon(
                  Icons.check,
                  color: Color(
                      0xffE53935), // Matches 'checkColor: Colors.green' (changed to white for better visibility on green background)
                  size: widget.size -
                      (widget.checkmarkPadding *
                          2.4), // Adjust size to fit padding
                ),
              )
            : null,
      ),
    );
  }
}
