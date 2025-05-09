import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wagons Learning Ltd',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '\u20B978.89 - \u20B982.89',
              style: TextStyle(
                color: isDark
                    ? Colors.white.withOpacity(0.6)
                    : Colors.black.withOpacity(0.6),
                fontSize: 12.sp,
              ),
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
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF121413) : Color(0xFFF4F4F9),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Investor type',
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedInvestor = 0),
                            child: constWidgets.choiceChip(
                              'Retail',
                              _selectedInvestor == 0,
                              context,
                              100.w,
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
                              100.w,
                              isDark,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Number of lots',
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Text('Max lots : $_maxLots',
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                  fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xFF121413) : Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                              color: isDark ? Colors.white24 : Colors.black12),
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
                                        fontSize: 18.sp,
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
                      SizedBox(height: 20.h),
                      Text('Bid Price',
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _bidPriceController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark ? Color(0xFF121413) : Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.scale(
                            scale: 0.9,
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
                          Text('Cut-off price',
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
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
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 6.h),
                      Text('Enter UPI ID linked to your bank account',
                          style: TextStyle(
                              color: isDark ? Colors.white60 : Colors.black54,
                              fontSize: 12)),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _upiController,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark ? Color(0xFF121413) : Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          hintText: 'UPI ID',
                          hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.black38),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
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
                  height: 1,
                  color: isDark ? const Color(0xFF2F2F2F) : Color(0xFFD1D5DB),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Payable Amount',
                              style: TextStyle(
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54)),
                          Text('₹13,46,678.68',
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.h),
                  child: constWidgets.greenButton("Apply for Ipo", onTap: () {
                    _showSuccessPopup(context);
                  }),
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
                'assets/svgs/applyIpo.svg',
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
