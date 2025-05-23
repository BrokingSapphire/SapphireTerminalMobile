import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/funds/funds.dart';
import 'package:sapphire/screens/account/account.dart';
import 'package:sapphire/screens/stockDetailedWindow/orders/ordersSDW.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';

class OrderSection extends StatefulWidget {
  const OrderSection({super.key});

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  late PageController _pageController;
  final List<String> tabs = ["Queued", "Executed", "Declined", "Cancelled"];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    print('Initial tab set to: ${tabs[_selectedIndex]}');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    print(
        'Tapped tab: Switching to ${tabs[index]} (from ${tabs[_selectedIndex]})');
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Instant switch for taps
    });
  }

  void _onPageChanged(int index) {
    print('Swiped to: ${tabs[index]} (from ${tabs[_selectedIndex]})');
    setState(() {
      _selectedIndex = index; // Update tab bar instantly on swipe
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Orders",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffEBEEF5),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () {
                          naviWithoutAnimation(context, FundsScreen());
                        },
                        child: SvgPicture.asset("assets/svgs/wallet.svg",
                            width: 20.w, height: 23.h, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        naviWithoutAnimation(context, ProfileScreen());
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff021814),
                        radius: 22.r,
                        child: Text(
                          "NK",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff22A06B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MarketDataCard("NIFTY 50", "23,018.20", "-218.20 (1.29%)"),
                    MarketDataCard("SENSEX", "73,018.20", "+218.20 (1.29%)"),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarHeaderDelegate(
                tabNames: tabs,
                selectedIndex: _selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ),
          ],
          body: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: tabs.length,
            itemBuilder: (context, index) =>
                OrderTabContent(tabType: tabs[index]),
          ),
        ),
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabTapped;

  final GlobalKey _menuButtonKey = GlobalKey();

  _TabBarHeaderDelegate({
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  double get minExtent => 35.h;

  @override
  double get maxExtent => 55.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xff000000),
      child: Stack(
        children: [
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
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(tabNames.length, (index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () => onTabTapped(index),
                      child: Container(
                        width: 80.w,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected
                                  ? Color(0xff1DB954)
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
                              tabNames[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.green : Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color(0xff121413),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 16.w),
                          minLeadingWidth: 16.w,
                          leading: Icon(Icons.show_chart),
                          title: Text(
                            "Stock SIP",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            print("Stock SIP selected");
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 16.w),
                          minLeadingWidth: 16.w,
                          leading: Icon(Icons.timeline),
                          title: Text(
                            "GTT Order",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            print("GTT Order selected");
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 16.w),
                          minLeadingWidth: 16.w,
                          leading: Icon(Icons.shopping_basket),
                          title: Text(
                            "Basket Order",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            print("Basket Order selected");
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Icon(
                        Icons.more_vert,
                        key: _menuButtonKey,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return tabNames != oldDelegate.tabNames ||
        selectedIndex != oldDelegate.selectedIndex;
  }
}

class OrderTabContent extends StatefulWidget {
  final String tabType;

  const OrderTabContent({required this.tabType});

  @override
  State<OrderTabContent> createState() => _OrderTabContentState();
}

class _OrderTabContentState extends State<OrderTabContent> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Define different data for each tab with 17 entries (original 2 + 15 more)
    List<Map<String, String>> orderData;
    switch (widget.tabType) {
      case "Queued":
        orderData = [
          {
            "title": "KOTAKBANK",
            "quantity": "50/100",
            "time": "12:34:59",
            "price": "₹1,67,580.60",
            "ltp": "₹1,995.55",
            "change": "(-1.06%)",
            "type": "DEL"
          },
          {
            "title": "RELIANCE",
            "quantity": "20/50",
            "time": "13:15:22",
            "price": "₹2,50,000.00",
            "ltp": "₹2,500.00",
            "change": "(+0.50%)",
            "type": "CFD"
          },
          {
            "title": "TCS",
            "quantity": "30/60",
            "time": "12:45:10",
            "price": "₹3,20,150.75",
            "ltp": "₹2,125.00",
            "change": "(+0.75%)",
            "type": "INT"
          },
          {
            "title": "HDFCBANK",
            "quantity": "40/80",
            "time": "13:00:33",
            "price": "₹1,60,024.30",
            "ltp": "₹1,800.60",
            "change": "(-0.25%)",
            "type": "MTF"
          },
          {
            "title": "ICICIBANK",
            "quantity": "25/50",
            "time": "13:22:45",
            "price": "₹1,10,500.20",
            "ltp": "₹1,220.30",
            "change": "(+0.10%)",
            "type": "DEL"
          },
          {
            "title": "SBIN",
            "quantity": "60/120",
            "time": "14:05:18",
            "price": "₹75,360.40",
            "ltp": "₹750.00",
            "change": "(-0.50%)",
            "type": "CFD"
          },
          {
            "title": "INFY",
            "quantity": "15/30",
            "time": "14:30:50",
            "price": "₹1,45,112.75",
            "ltp": "₹1,500.00",
            "change": "(+0.20%)",
            "type": "INT"
          },
          {
            "title": "BAJFINANCE",
            "quantity": "10/20",
            "time": "15:00:15",
            "price": "₹6,80,500.00",
            "ltp": "₹3,920.25",
            "change": "(-1.00%)",
            "type": "MTF"
          },
        ];
        break;
      case "Executed":
        orderData = [
          {
            "title": "HDFC",
            "quantity": "100/100",
            "time": "14:25:39",
            "price": "₹1,20,450.80",
            "ltp": "₹1,800.60",
            "change": "(+0.86%)"
          },
          {
            "title": "TCS",
            "quantity": "80/80",
            "time": "15:10:02",
            "price": "₹3,60,870.30",
            "ltp": "₹2,125.10",
            "change": "(+0.45%)"
          },
          {
            "title": "ICICIBANK",
            "quantity": "150/150",
            "time": "14:35:15",
            "price": "₹1,65,030.45",
            "ltp": "₹1,220.30",
            "change": "(-0.10%)"
          },
          {
            "title": "SBIN",
            "quantity": "200/200",
            "time": "14:50:28",
            "price": "₹1,50,080.00",
            "ltp": "₹750.00",
            "change": "(+0.20%)"
          },
          {
            "title": "INFY",
            "quantity": "90/90",
            "time": "15:05:40",
            "price": "₹1,35,067.50",
            "ltp": "₹1,500.00",
            "change": "(+0.30%)"
          },
          {
            "title": "BAJFINANCE",
            "quantity": "40/40",
            "time": "15:20:55",
            "price": "₹6,72,900.00",
            "ltp": "₹3,920.25",
            "change": "(-0.50%)"
          },
          {
            "title": "HINDUNILVR",
            "quantity": "60/60",
            "time": "15:35:12",
            "price": "₹2,40,054.00",
            "ltp": "₹2,400.90",
            "change": "(+0.15%)"
          },
          {
            "title": "ASIANPAINT",
            "quantity": "70/70",
            "time": "15:50:30",
            "price": "₹2,87,017.50",
            "ltp": "₹2,900.25",
            "change": "(+0.25%)"
          },
          {
            "title": "MARUTI",
            "quantity": "15/15",
            "time": "16:05:45",
            "price": "₹12,48,105.50",
            "ltp": "₹12,500.70",
            "change": "(-0.20%)"
          },
          {
            "title": "BHARTIARTL",
            "quantity": "50/50",
            "time": "16:20:18",
            "price": "₹94,540.00",
            "ltp": "₹950.80",
            "change": "(+0.40%)"
          },
          {
            "title": "LT",
            "quantity": "25/25",
            "time": "16:35:40",
            "price": "₹3,39,025.00",
            "ltp": "₹3,400.10",
            "change": "(+0.10%)"
          },
          {
            "title": "AXISBANK",
            "quantity": "30/30",
            "time": "16:50:15",
            "price": "₹1,04,510.50",
            "ltp": "₹1,050.35",
            "change": "(-0.30%)"
          },
          {
            "title": "ITC",
            "quantity": "100/100",
            "time": "17:05:30",
            "price": "₹42,550.00",
            "ltp": "₹425.50",
            "change": "(+0.05%)"
          },
          {
            "title": "WIPRO",
            "quantity": "40/40",
            "time": "17:20:45",
            "price": "₹1,80,300.00",
            "ltp": "₹1,807.50",
            "change": "(-0.10%)"
          },
          {
            "title": "ADANIENT",
            "quantity": "20/20",
            "time": "17:35:10",
            "price": "₹3,00,240.00",
            "ltp": "₹3,001.20",
            "change": "(+0.80%)"
          },
          {
            "title": "HCLTECH",
            "quantity": "50/50",
            "time": "17:50:25",
            "price": "₹1,65,780.00",
            "ltp": "₹1,657.80",
            "change": "(+0.15%)"
          },
          {
            "title": "NTPC",
            "quantity": "80/80",
            "time": "18:00:00",
            "price": "₹380.40",
            "ltp": "₹380.40",
            "change": "(+0.00%)"
          },
        ];
        break;
      case "Declined":
        orderData = [
          {
            "title": "ICICIBANK",
            "quantity": "200/250",
            "time": "15:13:22",
            "price": "₹2,45,780.90",
            "ltp": "₹1,220.30",
            "change": "(-0.75%)",
            "type": "DELIVERY"
          },
          {
            "title": "SBIN",
            "quantity": "150/200",
            "time": "16:00:45",
            "price": "₹1,50,000.00",
            "ltp": "₹750.00",
            "change": "(-1.20%)",
            "type": "CARRYFORWARD"
          },
          {
            "title": "RELIANCE",
            "quantity": "30/40",
            "time": "15:20:10",
            "price": "₹2,48,500.00",
            "ltp": "₹2,500.00",
            "change": "(-0.60%)",
            "type": "INTRADAY"
          },
          {
            "title": "TCS",
            "quantity": "40/50",
            "time": "15:35:25",
            "price": "₹3,18,125.00",
            "ltp": "₹2,125.10",
            "change": "(+0.10%)",
            "type": "MTF"
          },
        ];
        break;
      case "Cancelled":
        orderData = [
          {
            "title": "BAJFINANCE",
            "quantity": "30/50",
            "time": "16:47:55",
            "price": "₹5,90,640.50",
            "ltp": "₹3,920.25",
            "change": "(+1.24%)",
            "type": "DELIVERY"
          },
          {
            "title": "INFY",
            "quantity": "60/100",
            "time": "17:20:30",
            "price": "₹90,000.00",
            "ltp": "₹1,500.00",
            "change": "(-0.30%)",
            "type": "CARRYFORWARD"
          },
          {
            "title": "KOTAKBANK",
            "quantity": "20/40",
            "time": "16:55:10",
            "price": "₹1,78,024.60",
            "ltp": "₹1,995.55",
            "change": "(-0.15%)",
            "type": "INTRADAY"
          },
          {
            "title": "RELIANCE",
            "quantity": "15/30",
            "time": "17:10:25",
            "price": "₹2,49,500.00",
            "ltp": "₹2,500.00",
            "change": "(+0.20%)",
            "type": "MTF"
          },
          {
            "title": "HDFCBANK",
            "quantity": "30/60",
            "time": "17:40:15",
            "price": "₹1,62,018.00",
            "ltp": "₹1,800.60",
            "change": "(+0.10%)",
            "type": "CARRYFORWARD"
          },
          {
            "title": "ICICIBANK",
            "quantity": "20/40",
            "time": "17:55:30",
            "price": "₹1,10,220.00",
            "ltp": "₹1,220.30",
            "change": "(-0.20%)",
            "type": "INTRADAY"
          },
          {
            "title": "SBIN",
            "quantity": "40/80",
            "time": "18:10:45",
            "price": "₹75,200.00",
            "ltp": "₹750.00",
            "change": "(-0.40%)",
            "type": "DELIVERY"
          },
          {
            "title": "INFY",
            "quantity": "10/20",
            "time": "18:25:20",
            "price": "₹1,48,025.00",
            "ltp": "₹1,500.00",
            "change": "(+0.15%)",
            "type": "MTF"
          },
          {
            "title": "HINDUNILVR",
            "quantity": "15/30",
            "time": "18:40:35",
            "price": "₹2,39,050.00",
            "ltp": "₹2,400.90",
            "change": "(-0.10%)",
            "type": "DELIVERY"
          },
          {
            "title": "ASIANPAINT",
            "quantity": "20/40",
            "time": "18:55:10",
            "price": "₹2,89,025.00",
            "ltp": "₹2,900.25",
            "change": "(+0.05%)",
            "type": "CARRYFORWARD"
          },
          {
            "title": "MARUTI",
            "quantity": "5/10",
            "time": "19:10:25",
            "price": "₹12,49,070.00",
            "ltp": "₹12,500.70",
            "change": "(-0.25%)",
            "type": "INTRADAY"
          },
          {
            "title": "BHARTIARTL",
            "quantity": "25/50",
            "time": "19:25:40",
            "price": "₹95,030.00",
            "ltp": "₹950.80",
            "change": "(+0.20%)",
            "type": "MTF"
          },
          {
            "title": "LT",
            "quantity": "15/30",
            "time": "19:40:15",
            "price": "₹3,41,010.00",
            "ltp": "₹3,400.10",
            "change": "(+0.30%)",
            "type": "DELIVERY"
          },
          {
            "title": "AXISBANK",
            "quantity": "20/40",
            "time": "19:55:30",
            "price": "₹1,05,035.00",
            "ltp": "₹1,050.35",
            "change": "(-0.15%)",
            "type": "CARRYFORWARD"
          },
          {
            "title": "ITC",
            "quantity": "30/60",
            "time": "20:10:45",
            "price": "₹42,600.00",
            "ltp": "₹425.50",
            "change": "(+0.10%)",
            "type": "INTRADAY"
          },
          {
            "title": "WIPRO",
            "quantity": "15/30",
            "time": "20:25:20",
            "price": "₹1,81,750.00",
            "ltp": "₹1,807.50",
            "change": "(-0.05%)",
            "type": "MTF"
          }
        ];
        break;
      default:
        orderData = [];
    }

    print(
        'Loading data for tab: ${widget.tabType}, ${orderData.length} orders');

    if (orderData.isEmpty) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              child: constWidgets.searchField(
                  context, "Search Everything...", "orders", isDark),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 64.h,
                      width: 64.w,
                      child: SvgPicture.asset("assets/svgs/doneMark.svg")),
                  SizedBox(height: 20.h),
                  Text(
                    "No ${widget.tabType} Orders",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      "Your ${widget.tabType.toLowerCase()} orders will appear here. Start trading now!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.sp, color: Color(0xffC9CACC)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      color: Color(0xff1DB954),
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              child: constWidgets.searchField(
                  context, "Search Everything...", "orders", isDark),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navi(OrdersDetails(), context);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: contentCard(
                        orderData[index]["title"]!,
                        orderData[index]["quantity"]!,
                        orderData[index]["time"]!,
                        orderData[index]["price"]!,
                        orderData[index]["ltp"]!,
                        orderData[index]["change"]!,
                        orderData[index]["type"] ?? "DEL",
                        orderStatus: widget.tabType,
                      ),
                    ),
                    if (index != orderData.length - 1)
                      Divider(color: const Color(0xff2f2f2f)),
                  ],
                );
              },
              childCount: orderData.length,
            ),
          ),
        ],
      ),
    );
  }
}

Widget contentCard(String title, String quantity, String time, String price,
    String ltp, String change, String type,
    {String? orderStatus}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Color(0xff143520),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text("BUY",
                    style: TextStyle(fontSize: 10.sp, color: Colors.green)),
              ),
              SizedBox(width: 4.w),
              _infoChip("NSE-EQ"),
            ],
          ),
          SizedBox(height: 6.h),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text(quantity + " Quantity",
                  style: TextStyle(
                      color: const Color(0xffEBEEF5), fontSize: 12.sp)),
            ],
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(
            children: [
              orderType(type),
              SizedBox(width: 6.w),
              SvgPicture.asset('assets/svgs/clock.svg',
                  height: 12.h,
                  colorFilter: ColorFilter.mode(
                      const Color(0xffEBEEF5), BlendMode.srcIn)),
              SizedBox(width: 6.w),
              Text(time,
                  style: TextStyle(
                      color: const Color(0xffEBEEF5), fontSize: 10.sp)),
            ],
          ),
          SizedBox(height: 6.h),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          SizedBox(height: 6.h),
          Row(
            children: [
              Row(
                children: [
                  Text("LTP",
                      style:
                          TextStyle(color: Color(0xffc9cacc), fontSize: 12.sp)),
                  SizedBox(width: 4.w),
                  Text(ltp,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                ],
              ),
              SizedBox(width: 4.w),
              Text(change,
                  style: TextStyle(
                      color: change.startsWith('+') ? Colors.green : Colors.red,
                      fontSize: 12.sp)),
            ],
          ),
        ]),
      ],
    ),
  );
}

Widget _infoChip(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: Color(0xff303030),
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}

Widget orderType(String label) {
  final colors = _getChipColors(label);

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: colors['background'],
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.sp,
        color: colors['text'],
      ),
    ),
  );
}

Map<String, Color> _getChipColors(String label) {
  switch (label.toUpperCase()) {
    case 'DEL':
      return {
        'background': Color(0xff1e2e2a),
        'text': Color(0xffa5d6c9),
      };
    case 'INT':
      return {
        'background': Color(0xff33260d),
        'text': Color(0xffffb74d),
      };
    case 'CFD':
      return {
        'background': Color(0xff1f2537),
        'text': Color(0xff9fa8da),
      };
    case 'MTF':
      return {
        'background': Color(0xff2a1e38),
        'text': Color(0xffce93d8),
      };
    default:
      return {
        'background': Color(0xff1a1a1a),
        'text': Colors.white,
      };
  }
}

Widget MarketDataCard(String title, String price, String change) {
  final bool isPositive = change.startsWith('+');
  final Color changeColor = isPositive ? Colors.green : Colors.red;

  return Container(
    height: 62.h,
    width: 175.w,
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: const Color(0xff121413),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: const Color(0xff2F2F2F), width: 1.5.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: const Color(0xffEBEEF5),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: const Color(0xff121413),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                price,
                style:
                    TextStyle(color: const Color(0xffEBEEF5), fontSize: 12.sp),
              ),
              SizedBox(width: 6.w),
              Text(
                change,
                style: TextStyle(color: changeColor, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}