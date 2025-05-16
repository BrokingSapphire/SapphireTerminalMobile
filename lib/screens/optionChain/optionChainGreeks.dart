import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class optionChainGreek extends StatefulWidget {
  final String symbol;

  const optionChainGreek({super.key, required this.symbol});

  @override
  State<optionChainGreek> createState() => _optionChainGreekState();
}

class _optionChainGreekState extends State<optionChainGreek> {
  // Toggle state for Call column visibility
  bool _showCallData = true;

  // Data for the option chain
  final List<Map<String, dynamic>> optionChainData = [
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
    {
      'call': '310',
      'put': '310',
      'price': '₹1,580.60',
      'percentChange': '+4.55%',
      'iv': '64.7',
      'delta': '1.000',
      'theta': '-0.070',
      'vega': '0.000',
    },
  ];
  bool isCall = false;

  @override
  Widget build(BuildContext context) {
    // bool isDark = Theme.of.
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _buildHeaderRow(),
          ...optionChainData
              .map((data) => _buildOptionRow(
                    data['call'],
                    data['price'],
                    data['percentChange'],
                    data['iv'],
                    data['delta'],
                    data['theta'],
                    data['vega'],
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isCall = true),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          height: 18.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: isCall
                                ? Color(0xff1db954)
                                :
                                // isDark
                                Colors.transparent,
                            // : Color(0xFFF4F4F9),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Center(
                            child: Text(
                              'Call',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isCall
                                      ? Colors.white
                                      :
                                      //  isDark
                                      Colors.white
                                  // : Colors.black,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: () => setState(() => isCall = false),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          height: 18.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: !isCall
                                ? Color(0xff1db954)
                                // : isDark
                                : Colors.transparent,
                            // : Color(0xFFF4F4F9),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Center(
                            child: Text(
                              'Put',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: !isCall
                                      ? Colors.white
                                      // : isDark
                                      : Colors.white
                                  // : Colors.black,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Price",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "IV",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Delta",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Theta",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Vega",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildOptionRow(
    String call,
    String price,
    String percentChange,
    String iv,
    String delta,
    String theta,
    String vega,
  ) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              _showCallData ? call : "-",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     put,
          //     style: TextStyle(color: Colors.white, fontSize: 14.sp),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                Text(
                  percentChange,
                  style: TextStyle(
                      color: const Color(0xff1DB954), fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              iv,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              delta,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              theta,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              vega,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
