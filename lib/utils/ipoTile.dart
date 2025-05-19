// File: ipoTile.dart
// Description: Custom IPO listing tile widget for the Sapphire: Terminal Trading application.
// This file provides a reusable card-style component for displaying IPO details.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

typedef VoidCallback = void Function();

/// Creates a comprehensive IPO information tile with company details and subscription options
/// Displays company logo, key IPO details, subscription status, and an action button
///
/// Parameters:
/// - img: Asset path to the company logo image
/// - title: Company name or IPO title
/// - closeDate: Last date to apply for the IPO
/// - minInvestment: Minimum investment amount required
/// - badge1: Primary category/type badge (e.g., "Mainboard")
/// - badge2: Secondary category badge (e.g., "Fresh Issue")
/// - description: Company description text with "View more" option
/// - statusDay: Subscription day status (e.g., "Last Day")
/// - subscriptionStatus: Current subscription rate (e.g., "2.5x")
/// - price: IPO price range or final price
/// - lotSize: Number of shares in one lot
/// - onApply: Callback function for the "Apply now" button
Widget ipoTile({
  required String img,
  required String title,
  required String closeDate,
  required String minInvestment,
  required String badge1,
  required String badge2,
  required String description,
  required String statusDay,
  required String subscriptionStatus,
  required String price,
  required String lotSize,
  VoidCallback? onApply,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF121413), // Dark background for the card
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with company logo and basic details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company logo in a circular avatar
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Color(0xFF242525),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(img,
                    fit: BoxFit.contain, width: 32.w, height: 32.w),
              ),
            ),
            SizedBox(width: 14.w),

            // Company name and key info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company name
                  Text(title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 8.h),

                  // Closing date and minimum investment row
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Closes on : ",
                              style: TextStyle(
                                  color: Color(0xffc9cacc), fontSize: 10.sp),
                              children: [
                            TextSpan(
                                text: closeDate,
                                style: TextStyle(
                                    color: Color(0xFFEBEEF5), fontSize: 10.sp))
                          ])),
                      Spacer(),
                      RichText(
                          text: TextSpan(
                              text: "Min Investment : ",
                              style: TextStyle(
                                  color: Color(0xffc9cacc), fontSize: 10.sp),
                              children: [
                            TextSpan(
                                text: minInvestment,
                                style: TextStyle(
                                    color: Color(0xFFEBEEF5), fontSize: 10.sp))
                          ])),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Category badges row (Mainboard, Fresh Issue, etc.)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Primary badge (e.g., "Mainboard")
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Color(0xFF491787).withAlpha(
                              (255 * 0.5).round()), // Purple background
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(badge1,
                            style: TextStyle(
                                color: Color(0xffCBA0FF), fontSize: 10.sp)),
                      ),
                      SizedBox(width: 8.w),

                      // Secondary badge (e.g., "Fresh Issue")
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          color: Color(0xFF303030), // Dark gray background
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(badge2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Company description with "View more" option
        Text.rich(
          TextSpan(
            text: description.split("... ")[0] + "... ",
            style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
            children: [
              TextSpan(
                text: "View more",
                style: TextStyle(
                  color: Color(0xFFB7B7B7),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),

        // Subscription status container
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF3a3a3a)
                .withAlpha((255 * 0.5).round()), // Slightly lighter background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Status day badge (e.g., "Last Day")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9C544)
                      .withAlpha((255 * 0.2).round()), // Golden yellow
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(statusDay,
                    style:
                        TextStyle(color: Color(0xffD9C544), fontSize: 12.sp)),
              ),
              SizedBox(width: 8),
              Text("Subscription status",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp)),
              Spacer(),
              // Subscription rate (e.g., "2.5x")
              Text(subscriptionStatus,
                  style: TextStyle(
                    color:
                        Color(0xFF22A06B), // Green text for positive indication
                    fontSize: 13.sp,
                  )),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        // Price and lot size row
        Row(
          children: [
            // Price column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price",
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
                SizedBox(height: 4.h),
                Text("₹ $price",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Spacer(),
            // Lot size column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Lot Size",
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
                SizedBox(height: 4.h),
                Text(lotSize,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Apply now button
        SizedBox(
          width: 130.w,
          height: 38.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1DB954), // Brand green color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed:
                onApply ?? () {}, // Use provided callback or empty function
            child: Text(
              "Apply now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
