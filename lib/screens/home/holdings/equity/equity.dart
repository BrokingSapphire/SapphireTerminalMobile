import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/home/holdings/holdingsBottomSheet.dart';
import 'package:sapphire/utils/constWidgets.dart';

class EquityScreen extends StatefulWidget {
  const EquityScreen({super.key});

  @override
  State<EquityScreen> createState() => _EquityScreenState();
}

class _EquityScreenState extends State<EquityScreen> {
  // Text controller for search field
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy data for equity items
  final List<Map<String, String>> equityData = [
    {
      "name": "ALKYLAMINE",
      "quantity": "59 Qty × Avg 2,670.84",
      "loss": "93,979.60 (-12.2%)",
      "ltp": "LTP 1,731.05 (-1.63%)",
      "code": "ALKYL",
      "price": "1,731.05",
      "change": "-1.63%"
    },
    {
      "name": "RELIANCE",
      "quantity": "100 Qty × Avg 2,400.50",
      "loss": "-45,000.00 (-5.0%)",
      "ltp": "LTP 2,500.50 (+2.0%)",
      "code": "RELIANCE",
      "price": "2,500.50",
      "change": "+2.0%"
    },
    {
      "name": "TCS",
      "quantity": "80 Qty × Avg 3,000.25",
      "loss": "25,000.00 (-2.5%)",
      "ltp": "LTP 3,100.25 (+1.8%)",
      "code": "TCS",
      "price": "3,100.25",
      "change": "+1.8%"
    },
    {
      "name": "INFY",
      "quantity": "120 Qty × Avg 1,650.75",
      "loss": "-22,500.00 (-1.8%)",
      "ltp": "LTP 1,700.50 (+3.2%)",
      "code": "INFY",
      "price": "1,700.50",
      "change": "+3.2%"
    },
    {
      "name": "HDFC",
      "quantity": "60 Qty × Avg 2,500.10",
      "loss": "-15,000.00 (-2.0%)",
      "ltp": "LTP 2,550.20 (+1.5%)",
      "code": "HDFC",
      "price": "2,550.20",
      "change": "+1.5%"
    },
    {
      "name": "ICICIBANK",
      "quantity": "75 Qty × Avg 700.80",
      "loss": "8,500.00 (-1.2%)",
      "ltp": "LTP 720.50 (+1.3%)"
    },
    {
      "name": "SBIN",
      "quantity": "90 Qty × Avg 400.20",
      "loss": "6,000.00 (-1.0%)",
      "ltp": "LTP 410.50 (+1.5%)"
    },
    {
      "name": "BAJFINANCE",
      "quantity": "50 Qty × Avg 6,000.10",
      "loss": "-10,000.00 (-1.5%)",
      "ltp": "LTP 6,100.20 (+2.0%)"
    },
    {
      "name": "TATAMOTORS",
      "quantity": "110 Qty × Avg 460.00",
      "loss": "-7,500.00 (-2.0%)",
      "ltp": "LTP 470.25 (+1.5%)"
    },
    {
      "name": "HUL",
      "quantity": "70 Qty × Avg 2,100.75",
      "loss": "-5,500.00 (-1.0%)",
      "ltp": "LTP 2,150.30 (+2.1%)"
    },
    {
      "name": "ITC",
      "quantity": "95 Qty × Avg 220.60",
      "loss": "3,000.00 (-1.5%)",
      "ltp": "LTP 225.50 (+1.2%)"
    },
    {
      "name": "MARUTI",
      "quantity": "40 Qty × Avg 8,200.25",
      "loss": "-15,000.00 (-3.0%)",
      "ltp": "LTP 8,400.30 (+2.5%)"
    },
    {
      "name": "LT",
      "quantity": "85 Qty × Avg 1,700.50",
      "loss": "10,000.00 (-1.2%)",
      "ltp": "LTP 1,730.80 (+2.0%)"
    },
    {
      "name": "WIPRO",
      "quantity": "110 Qty × Avg 600.50",
      "loss": "-6,500.00 (-1.1%)",
      "ltp": "LTP 615.80 (+1.5%)"
    },
    {
      "name": "M&M",
      "quantity": "90 Qty × Avg 900.20",
      "loss": "5,500.00 (-0.8%)",
      "ltp": "LTP 920.50 (+2.3%)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sort the equity data alphabetically by name
    List<Map<String, String>> sortedEquityData = List.from(equityData);
    sortedEquityData.sort((a, b) => a["name"]!.compareTo(b["name"]!));

    // Filter the sorted equity data based on search query
    List<Map<String, String>> filteredEquityData = sortedEquityData;
    if (_searchQuery.isNotEmpty) {
      filteredEquityData = sortedEquityData.where((stock) {
        return stock["name"]!
            .toUpperCase()
            .startsWith(_searchQuery.toUpperCase());
      }).toList();
    }

    if (equityData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 64.h,
                width: 64.w,
                child: SvgPicture.asset("assets/svgs/doneMark.svg")),
            SizedBox(height: 20.h),
            Text("No Equity Found",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 10.h),
            SizedBox(
                width: 250.w,
                child: Text("Invest in stocks and track your portfolio here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey))),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
        },
        color: const Color(0xff1DB954), // Green refresh indicator
        backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 145.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: isDark
                          ? const Color(0xFF121413)
                          : const Color(0xFFF4F4F9)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      constWidgets.singleCard("Current Value", '₹15,11,750',
                          "Overall Loss", "-₹45,096", isDark),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Divider(
                          color: isDark
                              ? const Color(0xff2F2F2F)
                              : const Color(0xffD1D5DB),
                          thickness: 1,
                        ),
                      ),
                      constWidgets.singleCard("Invested Value", "₹19,91,071",
                          "Today’s Loss", "-₹4,837", isDark)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: constWidgets.searchFieldWithInput(
                    context, "Search by name or ticker", "equity", isDark,
                    controller: _searchController, onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                }),
              ),
              SizedBox(
                height: 12.h,
              ),
              // Show empty state if no results found
              if (filteredEquityData.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 64.h,
                            width: 64.w,
                            child: SvgPicture.asset("assets/svgs/doneMark.svg")),
                        SizedBox(height: 20.h),
                        Text("No Equity Found",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black)),
                        SizedBox(height: 10.h),
                        SizedBox(
                            width: 250.w,
                            child: Text(
                                "Invest in stocks and track your portfolio here.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.grey))),
                      ],
                    ),
                  ),
                )
              else
                // ListView.builder to render the filtered equity data
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => holdingsBottomSheet(
                            stockName: filteredEquityData[index]["name"]!,
                            stockCode:
                                filteredEquityData[index]["code"] ?? "NSE",
                            price: filteredEquityData[index]["price"] ?? "0.00",
                            change:
                                filteredEquityData[index]["change"] ?? "0.00%",
                          ),
                        );
                      },
                      child: constWidgets.equityScreenTiles(
                          filteredEquityData[index]["name"]!,
                          filteredEquityData[index]["quantity"]!,
                          filteredEquityData[index]["loss"]!,
                          filteredEquityData[index]["ltp"]!,
                          isDark),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: filteredEquityData.length,
                )
            ],
          ),
        ),
      ),
    );
  }
}
