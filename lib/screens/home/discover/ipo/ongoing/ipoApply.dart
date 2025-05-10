import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/discover/ipo/applied/ipoApplicationStatus.dart';
import 'package:sapphire/utils/constWidgets.dart';

class IPOApply extends StatefulWidget {
  const IPOApply({Key? key}) : super(key: key);

  @override
  State<IPOApply> createState() => _IPOApplyState();
}

class _IPOApplyState extends State<IPOApply>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int _selectedInvestor = 0; // 0: Retail, 1: HNI
  int _lots = 1;
  int _maxLots = 100000;
  TextEditingController _bidPriceController = TextEditingController(text: '87');
  TextEditingController _upiController = TextEditingController();
  bool _cutoffChecked = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
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
              "Wagons Learning Ltd",
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black),
            ),
            SizedBox(height: 4.h),
            Text(
              "₹78.89 - ₹82.89",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Color(0xff6B7280)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            color: isDark ? const Color(0xFF2F2F2F) : Color(0xFFD1D5DB),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                // Investor Type section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF121413) : Color(0xFFF4F4F9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Investor type',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          )),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedInvestor = 0),
                            child: constWidgets.choiceChip(
                              'Retail',
                              _selectedInvestor == 0,
                              context,
                              112.w,
                              isDark,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () => setState(() => _selectedInvestor = 1),
                            child: constWidgets.choiceChip(
                              'HNI',
                              _selectedInvestor == 1,
                              context,
                              112.w,
                              isDark,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Number of lots',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isDark ? Colors.white : Colors.black,
                              )),
                          Text('Max lots : $_maxLots',
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                  fontSize: 11.sp)),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                              color:
                                  isDark ? Color(0xff2f2f2f) : Colors.black12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove,
                                  color: isDark ? Colors.white : Colors.black),
                              onPressed: _lots > 1
                                  ? () => setState(() => _lots--)
                                  : null,
                            ),
                            Expanded(
                              child: Center(
                                child: Text('$_lots',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add,
                                  color: isDark ? Colors.white : Colors.black),
                              onPressed: _lots < _maxLots
                                  ? () => setState(() => _lots++)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text('Bid Price',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          )),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 48.h,
                        child: TextField(
                          controller: _bidPriceController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 13.sp,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 16.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: Checkbox(
                              value: _cutoffChecked,
                              onChanged: (v) =>
                                  setState(() => _cutoffChecked = v ?? false),
                              activeColor: Color(0xFF6FCF97),
                              side: BorderSide(
                                  color:
                                      isDark ? Colors.white38 : Colors.black38),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text('Cut-off price',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark ? Colors.white : Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // UPI Section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xFF181818) : Color(0xFFF4F4F9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter UPI ID',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          )),
                      SizedBox(height: 6.h),
                      Text('Enter UPI ID linked to your bank account',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isDark ? Colors.white : Colors.black54,
                          )),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 48.h,
                        child: TextField(
                          controller: _upiController,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 13.sp,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  6.r), // Corner radius set to 6.r
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFF2F2F2F)), // Border color #2F2F2F
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 16.h,
                            ),
                            hintText: 'UPI ID',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text('VERIFY UPI',
                              style: TextStyle(
                                  color: Color(0xFFC9CACC),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom bar
          Container(
            color: isDark ? Colors.black : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1.h,
                  color: isDark ? const Color(0xFF2F2F2F) : Color(0xFFD1D5DB),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Payable Amount',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54)),
                          Text('₹13,46,678.68',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: constWidgets.greenButton("Apply for IPO", onTap: () {
                    _showSuccessPopup(context);
                  }),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessPopup(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success icon
              SizedBox(height: 24.h),
              SvgPicture.asset(
                'assets/svgs/doneMark.svg',
                // color: isDark ? Colors.white : Colors.black,
              ),
              SizedBox(height: 24.h),
              // Success text
              Text(
                'Successfully Applied for IPO',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // Description text
              Text(
                'The payment mandate will be sent to your UPI application shortly.',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: isDark
                      ? Colors.white.withOpacity(0.7)
                      : Colors.black.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // View Application Status button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    navi(ipoApplication(), context);
                    // Add navigation to application status page if needed
                  },
                  child: Text(
                    'View Application Status',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1DB954),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
