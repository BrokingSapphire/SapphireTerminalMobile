import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class fundSettelmentFrequency extends StatefulWidget {
  const fundSettelmentFrequency({super.key});

  @override
  State<fundSettelmentFrequency> createState() =>
      _fundSettelmentFrequencyState();
}

class _fundSettelmentFrequencyState extends State<fundSettelmentFrequency> {
  int selectedIndex = 0;
  final List<String> options = [
    "90 days",
    "30 days",
    "Bill to Bill settlement",
  ];
  final List<String> descriptions = [
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
    "Unused funds will be transfered to your bank account on the first Friday of every quarter",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Fund Settlement Frequency",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Divider(color: Color(0xFF2F2F2F)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Text(
                      "Funds available in your Sapphire account will be trasferred to your registered bank account based on the selection made below",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    children: List.generate(options.length, (index) {
                      bool selected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 14.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Custom radio
                              Container(
                                margin: EdgeInsets.only(top: 2.h, right: 14.w),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected
                                        ? Color(0xFF22A06B)
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                ),
                                child: selected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF22A06B),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      options[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      descriptions[index],
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13.5.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 280.h),
                  constWidgets.greenButton("Proceed", onTap: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
