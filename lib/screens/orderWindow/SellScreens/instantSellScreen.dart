import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/animatedToggles.dart';

class SellScreenTabContent extends StatefulWidget {
  final String tabName;
  SellScreenTabContent(this.tabName);

  @override
  _SellScreenTabContentState createState() => _SellScreenTabContentState();
}

class _SellScreenTabContentState extends State<SellScreenTabContent> {
  int _selectedIndex = 0;
  bool isMarketSelected = true;
  int quantity = 1;
  TextEditingController priceController =
      TextEditingController(text: "6643.80");
  final List<String> _options = ["Delivery", "Intraday", "MTF"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            AnimatedOptionToggle(
              options: _options,
              selectedIndex: _selectedIndex,
              onToggle: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Quantity",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff2f2f2f)),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  height: 50.h,
                  width: 185.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: AnimatedDualToggle(
                    isFirstOptionSelected: isMarketSelected,
                    onToggle: (value) {
                      setState(() {
                        isMarketSelected = value;
                      });
                    },
                    firstOption: "Market",
                    secondOption: "Limit",
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Price",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 15.sp, color: Color(0xffc9cacc)),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₹",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Container(
                        height: 26.h,
                        width: 2.w,
                        color: Color(0xff2f2f2f),
                      )
                    ],
                  ),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Color(0xff2f2f2f)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: "Enter Price",
                hintStyle:
                    TextStyle(color: Colors.grey.shade600, fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
