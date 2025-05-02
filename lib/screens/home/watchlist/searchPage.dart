import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({super.key});

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentIndex = 0;

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
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredStocks() {
    String selected = options[_currentIndex].toLowerCase();
    if (selected == "all") return stocks;
    return stocks.where((stock) => stock["type"] == selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appColors = AppColors(isDark: isDark);

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // Search bar header
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 10.h, right: 16.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: appColors.textColor),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: SizedBox(
                        height: 42.h,
                        child: TextField(
                          autofocus: true,
                          inputFormatters: [
                            UpperCaseTextFormatter(), // Custom formatter to force uppercase
                          ],
                          decoration: InputDecoration(
                            hintText: "Search Instruments to add",
                            hintStyle: TextStyle(
                              color: appColors.secondaryTextColor,
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: appColors.searchFieldColor,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 10.w),
                              child: SvgPicture.asset(
                                'assets/svgs/search-svgrepo-com (1).svg',
                                width: 18.w,
                                height: 18.h,
                                colorFilter: ColorFilter.mode(
                                  appColors.textColor,
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
                            color: appColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Custom tab bar (original design)
              Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: appColors.tabBarColor,
                  border: Border(
                    bottom: BorderSide(
                      color: appColors.borderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(options.length, (index) {
                    final isSelected = index == _currentIndex;
                    return GestureDetector(
                      onTap: () {
                        // Direct update without animations for fastest response
                        if (_currentIndex != index) {
                          setState(() {
                            _currentIndex = index;
                          });
                          _pageController.jumpToPage(index);
                        }
                      },
                      child: Container(
                        width: 75.w,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected
                                  ? appColors.accentColor
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
                              options[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? appColors.accentColor
                                    : appColors.textColor,
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Content with PageView for sliding
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (index) {
                    // Immediate update for best responsiveness
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: options.length,
                  itemBuilder: (context, pageIndex) {
                    // Filter stocks based on current page
                    String selected = options[pageIndex].toLowerCase();
                    final filteredStocks = selected == "all"
                        ? stocks
                        : stocks
                            .where((stock) => stock["type"] == selected)
                            .toList();

                    return filteredStocks.isEmpty
                        ? Center(
                            child: Text("No ${selected} stocks found",
                                style: TextStyle(color: appColors.textColor)))
                        : ListView.builder(
                            itemCount: filteredStocks.length,
                            itemBuilder: (context, index) {
                              final stock = filteredStocks[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _buildStockLogo(stock["image"]),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                stock["name"],
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: appColors.textColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                stock["date"],
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: appColors
                                                      .secondaryTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "NSE",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: appColors.textColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              stock["type"],
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: appColors
                                                    .secondaryTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20.w),
                                        InkWell(
                                          onTap: () {
                                            debugPrint(
                                                "${stock["name"]} added to watchlist!");
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svgs/bookmark-x.svg',
                                            colorFilter: ColorFilter.mode(
                                              Colors.green,
                                              BlendMode.srcIn,
                                            ),
                                            width: 22.w,
                                            height: 22.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: appColors.dividerColor,
                                    indent: 16.w,
                                    endIndent: 16.w,
                                  ),
                                ],
                              );
                            },
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

  // Safe image loading with error handling
  Widget _buildStockLogo(String imagePath) {
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(imagePath),
      onBackgroundImageError: (exception, stackTrace) {
        debugPrint('Error loading image: $exception');
      },
    );
  }
}

// Centralized color management
class AppColors {
  final bool isDark;

  const AppColors({required this.isDark});

  Color get backgroundColor => isDark ? const Color(0xFF000000) : Colors.white;
  Color get textColor => isDark ? Colors.white : Colors.black;
  Color get secondaryTextColor =>
      isDark ? const Color(0xFFC9CACC) : Colors.black54;
  Color get searchFieldColor =>
      isDark ? const Color(0xFF2F2F2F) : const Color(0xFFF4F4F9);
  Color get dividerColor => const Color(0xFF2F2F2F);
  Color get accentColor => const Color(0xFF1DB954); // Green accent color
  Color get tabBarColor => isDark ? const Color(0xFF000000) : Colors.white;
  Color get borderColor =>
      isDark ? const Color(0xFF2F2F2F) : const Color(0xFFE0E0E0);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
