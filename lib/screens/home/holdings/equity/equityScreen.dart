import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class EquityScreen extends StatefulWidget {
  const EquityScreen({super.key});

  @override
  State<EquityScreen> createState() => _EquityScreenState();
}

class _EquityScreenState extends State<EquityScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy data for equity items
    List<Map<String, String>> equityData = [
      {
        "name": "ALKYLAMINE",
        "quantity": "59 Qty × Avg 2,670.84",
        "loss": "93,979.60 (-12.2%)",
        "ltp": "LTP 1,731.05 (-1.63%)"
      },
      {
        "name": "RELIANCE",
        "quantity": "100 Qty × Avg 2,400.50",
        "loss": "-45,000.00 (-5.0%)",
        "ltp": "LTP 2,500.50 (+2.0%)"
      },
      {
        "name": "TCS",
        "quantity": "80 Qty × Avg 3,000.25",
        "loss": "25,000.00 (-2.5%)",
        "ltp": "LTP 3,100.25 (+1.8%)"
      },
      {
        "name": "INFY",
        "quantity": "120 Qty × Avg 1,650.75",
        "loss": "-22,500.00 (-1.8%)",
        "ltp": "LTP 1,700.50 (+3.2%)"
      },
      {
        "name": "HDFC",
        "quantity": "60 Qty × Avg 2,500.10",
        "loss": "-15,000.00 (-2.0%)",
        "ltp": "LTP 2,550.20 (+1.5%)"
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

    if (equityData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 150.h,
                width: 150.w,
                child: Image.asset("assets/emptyPng/holdingEquity.png")),
            Text(
              "No Holdings Found",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 250.w,
              child: Text(
                "Invest in stocks and track your portfolio here",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 145.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: const Color(0xFF121413)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    constWidgets.singleCard("Current Value", '₹15,11,750',
                        "Overall Loss", "-₹45,096"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Divider(
                        color: Color(0xff2F2F2F),
                        thickness: 1,
                      ),
                    ),
                    constWidgets.singleCard("Invested Value", "₹19,91,071",
                        "Today’s Loss", "-₹4,837")
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              constWidgets.searchField(
                  context, "Search Everything...", "equity"),
              SizedBox(
                height: 12.h,
              ),
              // ListView.builder to render the equity data
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return constWidgets.equityScreenTiles(
                      equityData[index]["name"]!,
                      equityData[index]["quantity"]!,
                      equityData[index]["loss"]!,
                      equityData[index]["ltp"]!);
                },
                itemCount: equityData.length,
                shrinkWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
