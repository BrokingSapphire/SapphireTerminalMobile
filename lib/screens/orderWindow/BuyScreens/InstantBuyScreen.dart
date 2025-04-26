import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/buyScreenWrapper.dart';
import 'package:sapphire/utils/animatedToggles.dart';

class BuyScreenTabContent extends StatefulWidget {
  final String tabName;

  BuyScreenTabContent(this.tabName);

  @override
  _BuyScreenTabContentState createState() => _BuyScreenTabContentState();
}

class _BuyScreenTabContentState extends State<BuyScreenTabContent> {
  int _selectedIndex = 0;
  bool isMarketSelected = true;
  int quantity = 1;
  TextEditingController priceController =
      TextEditingController(text: "6643.80");
  final List<String> _options = ["Delivery", "Intraday", "MTF"];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            buyAnimatedToggle(
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
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : Colors.black),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isDark
                            ? Color(0xff2f2f2f)
                            : Color(0xff2f2f2f).withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  height: 50.h,
                  width: 185.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,
                            color: isDark ? Colors.white : Colors.black),
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
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,
                            color: isDark ? Colors.white : Colors.black),
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
                  child: buyScreenToggle(
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
                style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark ? Colors.white : Colors.black),
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                  fontSize: 15.sp,
                  color: isDark ? Color(0xffc9cacc) : Colors.black),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₹",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: isDark ? Colors.white : Colors.black),
                      ),
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
                  borderSide: BorderSide(
                      color: isDark
                          ? Color(0xff2f2f2f)
                          : Color(0xff2f2f2f).withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide:
                      BorderSide(color: isDark ? Colors.white : Colors.black),
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
