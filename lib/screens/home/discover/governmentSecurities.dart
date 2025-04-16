import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GovernmeSecurities extends StatefulWidget {
  const GovernmeSecurities({super.key});

  @override
  State<GovernmeSecurities> createState() => _GovernmeSecuritiesState();
}

class _GovernmeSecuritiesState extends State<GovernmeSecurities> {
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
          "Government Securities",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: const Color(0xFF2F2F2F),
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Column(
              children: [
                Container(
                    width: 370.w,
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color(0xff121413),
                    ),
                    child: Column(
                      children: [
                        governmentSecuritiesTiles(
                          "assets/images/reliance logo.png", // img
                          "Akme Fintrade India ltd. (Aasaan Loans)", // title
                          "21 June 2025", // endDate
                          "6.80%", // yield
                          "GSEC", // badge1
                          "3,21,380.00", // price
                          "6,789.00", // lotSize
                          "CLOSING TODAY", // badge2
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget governmentSecuritiesTiles(
    String img,
    String title,
    String endDate,
    String yield,
    String badge1,
    String price,
    String lotSize,
    String badge2, // e.g. "CLOSING TODAY"
    {String description =
        "IIFL Finance is a Non-Banking Financial Company – Middle Layer (NBFC-ML), registered with the RBI, providing a wide range of financial products to meet the diverse credit needs of ...",
    bool showFullDescription = false,
    VoidCallback? onBid,
    VoidCallback? onViewMore}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Top Row: Logo, Title, End Date, Yield, Badges
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Color(0xFF242525),
            child: Image.asset(img,
                fit: BoxFit.contain, width: 32.w, height: 32.w),
          ),
          SizedBox(width: 14.w),
          // Title and End date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      "Ends on : $endDate",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                    Spacer(),
                    Text(
                      "Yield* : $yield",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge 1
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF6C3EB6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(badge1,
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    SizedBox(width: 8),
                    // Badge 2
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF444444),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(badge2,
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      // Description with View more
      Text.rich(
        TextSpan(
          text: showFullDescription
              ? description
              : description.split("... ")[0] + "... ",
          style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
          children: [
            if (!showFullDescription)
              TextSpan(
                text: "View more",
                style: TextStyle(
                  color: Color(0xFFB7B7B7),
                  decoration: TextDecoration.underline,
                ),
                recognizer:
                    null, // You can add a TapGestureRecognizer for actual action
              ),
          ],
        ),
        maxLines: showFullDescription ? null : 4,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 16.h),
      // Price and Lot Size row
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              SizedBox(height: 2),
              Text(price,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Lot Size",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              SizedBox(height: 2),
              Text(lotSize,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
      SizedBox(height: 14.h),
      // Place bid button
      SizedBox(
        width: 150.w,
        height: 44.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1DB954),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onBid ?? () {},
          child: Text(
            "Place bid",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}
