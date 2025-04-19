import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

// Make sure this is imported properly

class searchPageScreen extends StatefulWidget {
  const searchPageScreen({super.key});

  @override
  State<searchPageScreen> createState() => _searchPageScreenState();
}

class _searchPageScreenState extends State<searchPageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> options = ["All", "Cash", "Future", "Option", "MF"];

  final List<Map<String, dynamic>> stocks = [
    {
      "name": "RELIANCE",
      "date": "Reliance Industries Ltd.",
      "type": "cash",
      "image": "assets/images/reliance logo.png",
    },
    {
      "name": "RELIANCE FUT",
      "date": "27 Mar 2025",
      "type": "future",
      "image": "assets/images/reliance logo.png",
    },
    {
      "name": "RELIANCE FUT",
      "date": "24 Apr 2025",
      "type": "future",
      "image": "assets/images/reliance logo.png",
    },
    {
      "name": "RELIANCE 1200 CE",
      "date": "27 Mar 2025",
      "type": "option",
      "image": "assets/images/reliance logo.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: options.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredStocks() {
    String selected = options[_tabController.index].toLowerCase();
    if (selected == "all") return stocks;
    return stocks.where((stock) => stock["type"] == selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // Search Bar Row
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 10.h, right: 16.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: SizedBox(
                        height: 42.h,
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Search Anything...",
                            hintStyle: TextStyle(
                              color: isDark ? Colors.grey[400] : Colors.black,
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? const Color(0xff2F2F2F)
                                : const Color(0xFFF4F4F9),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 10.w),
                              child: SvgPicture.asset(
                                'assets/svgs/search-svgrepo-com (1).svg',
                                width: 18.w,
                                height: 18.h,
                                colorFilter: ColorFilter.mode(
                                  isDark ? Colors.white : Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 36.w,
                              minHeight: 36.h,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 18.h,
              ),
              // Custom Tab Bar
              CustomTabBar(
                tabController: _tabController,
                options: options,
              ),

              // List of Stocks
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 0),
                  itemCount: getFilteredStocks().length,
                  itemBuilder: (context, index) {
                    final stock = getFilteredStocks()[index];
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(stock["image"]),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stock["name"],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      stock["date"],
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: isDark
                                            ? Color(0xffC9CACC)
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "NSE",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    stock["type"],
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: isDark
                                          ? Color(0xffC9CACC)
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              InkWell(
                                onTap: () {
                                  print("${stock["name"]} added to watchlist!");
                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/Watchlist.svg',
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1.h,
                          color: const Color(0xff2F2F2F),
                          // indent: 16.w,
                          // endIndent: 16.w,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
