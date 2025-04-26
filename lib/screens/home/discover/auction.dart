import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Auction extends StatefulWidget {
  const Auction({super.key});

  @override
  State<Auction> createState() => _AuctionState();
}

class _AuctionState extends State<Auction> {
  List<Map<String, dynamic>> positionData = [
    {
      "title": "Bajaj Auto",
      "midtitle": "Holding Price ₹117.41",
      "subtitle": "#9956",
      "trail1": "+1995",
      "trail2": "Eligible qty. 5671",
      "trail3": "LTP 995.55",
      "isBuy": true,
    },
    {
      "title": "IDEA",
      "midtitle": "Holding Price ₹117.41",
      "subtitle": "#9956",
      "trail1": "-1995",
      "trail2": "Eligible qty. 5671",
      "trail3": "LTP 995.55",
      "isBuy": false,
    },
    {
      "title": "INDUSTOWER",
      "midtitle": "Holding Price ₹117.41",
      "subtitle": "#9956",
      "trail1": "+1955",
      "trail2": "Eligible qty. 5671",
      "trail3": "LTP 995.55",
      "isBuy": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          "Auction",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xFF2F2F2F),
            height: 1,
          ),
          SizedBox(height: 12.h),
          Column(
            children: [
              ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: positionData.length,
                        itemBuilder: (context, index) {
                          var data = positionData[index];
                          return auctionTileScreens(
                            "assets/images/reliance logo.png",
                            data['title'],
                            data['midtitle'],
                            data['subtitle'],
                            data['trail1'],
                            data['trail2'],
                            data['trail3'],
                            data['isBuy'],
                          );
                        })
                  ])
            ],
          )
        ],
      ),
    );
  }
}

Widget auctionTileScreens(
  String img,
  String title,
  String midtitle,
  String subtitle,
  String trail1,
  String trail2,
  String trail3,
  bool isBuy,
) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150.w,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 13.sp),
                      maxLines: 1, // Ensures the text stays on one line
                      overflow: TextOverflow
                          .ellipsis, // Truncates with an ellipsis when text overflows
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    midtitle,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("Holding P&L"),
                      SizedBox(width: 2.w),
                      Text(
                        trail1,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: trail1.startsWith("-")
                                ? Colors.red
                                : Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    trail2,
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    trail3,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Divider(
        color: Color(0xFF2f2f2f),
      )
    ],
  );
}
