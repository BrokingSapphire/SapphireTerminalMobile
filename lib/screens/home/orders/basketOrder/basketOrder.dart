import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/home/orders/basketOrder/basketSelect.dart';
import '../../../../utils/constWidgets.dart';

class basketScreen extends StatefulWidget {
  const basketScreen({super.key});

  @override
  State<basketScreen> createState() => _basketScreenState();
}

class _basketScreenState extends State<basketScreen> {
  TextEditingController mybasketname = TextEditingController();

  final List<Map<String, dynamic>> baskets = const [
    {"name": "Stock 1", "date": "31 Jan 2025", "items": "02 items"},
    {"name": "Stock 2", "date": "31 Jan 2025", "items": "06 items"},
    {"name": "Stock 3", "date": "31 Jan 2025", "items": "02 items"},
    {"name": "Stock 56", "date": "Created on 31 Jan 2025", "items": "01 items"},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(kToolbarHeight), // Standard AppBar height
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AppBar(
              leadingWidth: 36.w,
              title: Text(
                "Basket",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(1.h), // Controls the height of the divider
                child: Divider(
                  color: Color(0xff2f2f2f), // Light grey divider for contrast
                  thickness: 1, // Divider thickness
                  height: 1, // Ensures it sticks to the bottom of the AppBar
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: constWidgets.searchField(
                    context, "Search Everything...", "orders", isDark),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("04 Baskets",
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xffEBEEF5))),
                    InkWell(
                      onTap: () {
                        _showCreateBasketModal(context, isDark);
                      },
                      child: Text(
                        "+ New Basket",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView.builder(
                  itemCount: baskets.length,
                  itemBuilder: (context, index) {
                    final basket = baskets[index];
                    return Column(
                      children: [
                        Card(
                          color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Column for title and subtitle
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      basket["name"],
                                      style: TextStyle(
                                          color: Color(0xffEBEEF5),
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      basket["date"],
                                      style: TextStyle(
                                          color: Color(0xffC9CACC),
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                                // Text for items
                                Text(
                                  basket["items"],
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Color(0xff2F2F2F)),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateBasketModal(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xff121413),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create New Basket",
                      style: TextStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Basket Name",
                  style: TextStyle(color: Color(0xffEBEEF5), fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 12.h),
              constWidgets.textField("MY BSKT", mybasketname, isDark: isDark),
              SizedBox(height: 16.h),
              constWidgets.greenButton("Create", onTap: () {
                navi(basketSelectScreen(), context);
              }),
              SizedBox(
                height: 15.h,
              )
            ],
          ),
        );
      },
    );
  }
}
