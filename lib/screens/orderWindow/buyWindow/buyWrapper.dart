import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:holdable_button/utils/utils.dart';
import 'package:sapphire/screens/home/orders/gttOrder/gttScreenWrapper.dart';
import 'package:sapphire/screens/orderWindow/buyWindow/coverBuy.dart';
import 'package:sapphire/screens/orderWindow/buyWindow/icebergBuy.dart';
import 'package:sapphire/screens/orderWindow/buyWindow/instantBuy.dart';
import 'package:sapphire/screens/orderWindow/buyWindow/normalBuy.dart';

import 'package:sapphire/utils/constWidgets.dart';

class BuyScreenWrapper extends StatefulWidget {
  final bool isbuy;

  BuyScreenWrapper({Key? key, required this.isbuy}) : super(key: key);

  @override
  _BuyScreenWrapperState createState() => _BuyScreenWrapperState();
}

class _BuyScreenWrapperState extends State<BuyScreenWrapper>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  bool isNSE = true;
  String _selectedOrderType = "Buy";
  int _selectedIndex = 0;

  List<String> list = ["Instant", "Normal", "Iceberg", "Cover"];

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

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index; // Update tab bar instantly on swipe
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Instant switch for taps
    });
  }

  void _onSwipe(bool isLeftSwipe) {
    setState(() {
      if (isLeftSwipe && _pageController.page! < list.length - 1) {
        _pageController.animateTo(_pageController.page! + 1,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else if (!isLeftSwipe && _pageController.page! > 0) {
        _pageController.animateTo(_pageController.page! - 1,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // This is the key setting that ensures the bottom nav bar moves up with keyboard
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: isDark ? Colors.black : Colors.white,
            leadingWidth: 28,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RELIANCE",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(height: 4.h),
                Text(
                  "₹1,256.89 (+1.67%)",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Color(0xff6B7280)),
                ),
              ],
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff2F2F2F) : Color(0xfff4f4f9),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                child: Row(
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
                          color: isNSE
                              ? Color(0xff1db954)
                              : isDark
                                  ? Colors.transparent
                                  : Color(0xFFF4F4F9),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            'NSE',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: isNSE
                                  ? Colors.white
                                  : isDark
                                      ? Colors.white
                                      : Colors.black,
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
                          color: !isNSE
                              ? Color(0xff1db954)
                              : isDark
                                  ? Colors.transparent
                                  : Color(0xFFF4F4F9),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            'BSE',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: !isNSE
                                  ? Colors.white
                                  : isDark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("object");
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6.r), // Reduced border radius
                      ),
                      backgroundColor:
                          isDark ? Color(0xff121413) : Colors.white,
                      title: Text(
                        "Order Type",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      content: Container(
                        height: 80.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _selectedOrderType = "Buy";
                                });
                                Navigator.of(context).pop("Buy");
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    decoration: BoxDecoration(
                                      color: _selectedOrderType == "Buy"
                                          ? Colors.green
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.r),
                                        bottomLeft: Radius.circular(6.r),
                                      ),
                                    ),
                                    height: 35.h,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        color: _selectedOrderType == "Buy"
                                            ? Colors.grey.shade900
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6.r),
                                          bottomRight: Radius.circular(6.r),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w, top: 5.h),
                                        child: Text(
                                          "Buy",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _selectedOrderType = "Sell";
                                });
                                Navigator.of(context).pop("Sell");
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: _selectedOrderType == "Sell"
                                          ? Color(0xffE53935)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.r),
                                        bottomLeft: Radius.circular(6.r),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        color: _selectedOrderType == "Sell"
                                            ? Colors.grey.shade900
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6.r),
                                          bottomRight: Radius.circular(6.r),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w, top: 5.h),
                                        child: Text(
                                          "Sell",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.more_vert_rounded,
                  color: isDark ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
          Divider(color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB)),
          SizedBox(height: 16.h),
          Container(
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
                children: List.generate(list.length, (index) {
                  final isSelected = index == _selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabTapped(index),
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
                              list[index],
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
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return BuyScreenTabContent("Instant");
                    case 1:
                      return NormalBuyScreen("Normal");
                    case 2:
                      return Icebergbuyscreen("Iceberg");
                    case 3:
                      return MTFBuyScreen("Cover");
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: Color(0xFF2F2F2F),
                  thickness: 0.5,
                  height: 1.h,
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Margin Required",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color:
                                    isDark ? Color(0xffC9CACC) : Colors.black),
                          ),
                          Text(
                            "₹75.68",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Charges",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color:
                                    isDark ? Color(0xffC9CACC) : Colors.black),
                          ),
                          Text(
                            "₹75.68",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Margin",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color:
                                    isDark ? Color(0xffC9CACC) : Colors.black),
                          ),
                          Text(
                            "₹2,56,897.89",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark ? Colors.white : Colors.black),
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
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: HoldableButton(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class buyScreenToggle extends StatelessWidget {
  // Required parameters
  final bool isFirstOptionSelected;
  final Function(bool) onToggle;
  final String firstOption;
  final String secondOption;

  // Optional customization parameters
  final Color? backgroundColor; // Background color of the toggle
  final Color? selectedColor; // Color of the selected tab
  final Color? textColor; // Text color for selected option
  final Color? unselectedTextColor; // Text color for unselected option
  final double height; // Height of the toggle
  final double borderRadius; // Border radius of the toggle corners

  buyScreenToggle({
    Key? key,
    required this.isFirstOptionSelected,
    required this.onToggle,
    required this.firstOption,
    required this.secondOption,
    this.backgroundColor, // Remove default values to allow theme-based colors
    this.selectedColor,
    this.textColor,
    this.unselectedTextColor,
    this.height = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if we're in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Define theme-specific colors
    final Color actualBackgroundColor = backgroundColor ??
        (isDark ? const Color(0xff2f2f2f) : const Color(0xfff5f5f5));

    final Color actualSelectedColor = selectedColor ??
        (isDark ? const Color(0xff1db954) : const Color(0xff1db954));

    final Color actualTextColor = textColor ?? Colors.white;

    final Color actualUnselectedTextColor = unselectedTextColor ??
        (isDark ? const Color(0xffebeef5) : const Color(0xff6B7280));

    return Container(
      height: height.h,
      // Apply theme-specific background color
      decoration: BoxDecoration(
        color: actualBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment
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
                  // Apply theme-specific selected color
                  decoration: BoxDecoration(
                    color: actualSelectedColor,
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          firstOption,
                          style: TextStyle(
                            // Apply appropriate text color based on selection state
                            color: isFirstOptionSelected
                                ? actualTextColor
                                : actualUnselectedTextColor,
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
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          secondOption,
                          style: TextStyle(
                            // Use consistent text color logic for second option
                            color: !isFirstOptionSelected
                                ? actualTextColor
                                : actualUnselectedTextColor,
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

class buyAnimatedToggle extends StatefulWidget {
  // Required parameters
  final List<String> options;
  final int selectedIndex;
  final Function(int) onToggle;

  // Optional customization parameters that can be theme-aware
  final Color? backgroundColor; // Background color of the entire toggle
  final Color? selectedBackgroundColor; // Background color of the selected tab
  final Color? selectedTextColor; // Text color for the selected option
  final Color? unselectedTextColor; // Text color for unselected options
  final double height; // Height of the toggle
  final double borderRadius; // Border radius of the toggle corners

  const buyAnimatedToggle({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onToggle,
    this.backgroundColor, // Remove default values to be theme-aware
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.height = 40,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  State<buyAnimatedToggle> createState() => _buyAnimatedToggleState();
}

class _buyAnimatedToggleState extends State<buyAnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    // Check if we're in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Define theme-specific colors
    final Color actualBackgroundColor = widget.backgroundColor ??
        (isDark ? const Color(0xff121413) : const Color(0xffF0F0F0));

    final Color actualSelectedBackgroundColor =
        widget.selectedBackgroundColor ??
            (isDark ? const Color(0xff2f2f2f) : Colors.white);

    final Color actualSelectedTextColor = widget.selectedTextColor ??
        (isDark ? const Color(0xff1db954) : const Color(0xff1db954));

    final Color actualUnselectedTextColor = widget.unselectedTextColor ??
        (isDark ? Colors.grey : const Color(0xff6B7280));

    return Container(
      height: widget.height.h,
      width: double.infinity,
      // Apply theme-specific background color
      decoration: BoxDecoration(
        color: actualBackgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate width for each segment based on number of options
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
                  // Apply theme-specific selected background color
                  decoration: BoxDecoration(
                    color: actualSelectedBackgroundColor,
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
                            // Apply appropriate text color based on selection state
                            color: widget.selectedIndex == index
                                ? actualSelectedTextColor
                                : actualUnselectedTextColor,
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
