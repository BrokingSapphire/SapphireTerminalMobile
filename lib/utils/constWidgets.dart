// File: constWidgets.dart
// Description: Collection of reusable UI components for the Sapphire: Terminal Trading application.
// This file provides standardized widgets to maintain consistent UI/UX across the app.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatting and validation
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/home/watchlist/searchPage.dart'; // Search page screen
import 'package:sapphire/utils/filters.dart'; // Filter utility for search and filtering

import '../main.dart'; // App-wide utilities and navigation

/// constWidgets - Static class containing reusable widgets used throughout the app
/// Note: Class name should be capitalized as per Dart conventions (ConstWidgets)
class constWidgets {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static segmentChoiceChipiWithCheckbox(
      String text, bool val, BuildContext context, bool isDark) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 2.w,
          ),
          Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: val,
                onChanged: (val) {
                  // You can add logic here if needed
                },

                // Adjust padding around the checkmark (e.g., 2.0, 4.0, or 6.0)
              )),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp, // Increased font size to match image
              fontWeight: FontWeight.w400,
              color: isDark
                  ? Colors.white
                  : Colors.black, // White text to match black background
            ),
          ),
        ],
      ),
      height: 45.h,
      width: 170.w, // Maintain half-screen width minus padding
      decoration: BoxDecoration(
        border: Border.all(
          color: val
              ? Colors.green
              : isDark
                  ? Colors.grey.shade800
                  : Color(0xffD1D5DB), // Gray border to match image
          width: 1.5, // Slightly thicker border for visibility
        ),
        borderRadius:
            BorderRadius.circular(8.r), // Larger rounded corners to match image
        color: val
            ? isDark
                ? Color(0xFF26382F)
                : Colors.green.withOpacity(0.3)
            : Colors.transparent, // Black background to match image
      ),
    );
  }

  /// Creates a search field with filter button
  /// Used on search-enabled screens like watchlist, orders, etc.
  static Widget searchField(
      BuildContext context, String hintText, String pageKey, bool isDark) {
    return Row(
      children: [
        // Expanded ensures TextField takes up full width
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Handle tap (e.g., navigate to search screen)
              navi(SearchPageScreen(), context); // Navigate to search screen
            },
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF121413) : Color(0xFFF4F4F9),
                // border: Border.all(
                //     color: isDark ? Colors.transparent : Colors.grey),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 22.sp,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hintText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w), // Small spacing

        // Square Filter Icon Container wrapped with GestureDetector
        GestureDetector(
          onTap: () {
            // Triggering the filter bottom sheet on tap
            showFilterBottomSheet(
              context: context,
              pageKey: pageKey, // Dynamically pass the pageKey here
              onApply: (selectedFilters) {
                // Handle the selected filters if needed
              },
              isDark: isDark,
            );
          },
          child: Container(
            height: 48.h,
            width: 48.h, // Square (same height & width)
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF121413) : Color(0xFFF4F4F9),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/filter.png',
                scale: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Displays a snackbar message
  /// Used for showing success, error, or info messages throughout the app
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
      String text, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: color,
        content: Text(
          text,
          style: TextStyle(color: Colors.white),
        )));
  }

  /// Creates a standard list item view for watchlist items
  /// Displays stock/security information with leading icon, title, subtitle, and trailing values
  static Widget watchListDataView(String leadImageLink, String title,
      String subtitle, String trail1, String trail2, bool isDark) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 14.h, horizontal: 16.w), // Padding for the container
          child: Row(
            children: [
              // Leading image (Circle Avatar)
              CircleAvatar(
                  radius: 18.r,
                  backgroundColor: isDark ? Colors.white : Colors.transparent,
                  backgroundImage:
                      AssetImage("assets/images/reliance logo.png")),
              SizedBox(width: 10.w), // Space between avatar and text

              // Column for Title and Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 0.h), // Space between title and subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ],
              ),

              // Spacer to push the trailing items to the end
              Spacer(),

              // Column for Trailing information
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹$trail1",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                  Text(
                    trail2,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: trail2.startsWith('-')
                            ? Color(0xffe53935) // Red color for negative values
                            : Color(
                                0xff22a06b)), // Green color for positive values
                  ),
                ],
              ),
            ],
          ),
        ),
        // Divider(
        //   height: 1,
        // ),
      ],
    );
  }

  /// Creates a card with two data values displayed side by side
  /// Used on portfolio, holdings, and other screens to display key metrics
  static Widget singleCard(String firtTitle, String firstValue,
      String secondTitle, String secondValue, bool isDark) {
    return Container(
      height: 120.h / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side data point
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firtTitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  firstValue,
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
            // Right side data point
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  secondTitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 4.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: secondValue,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp,
                            color: secondValue.contains('-')
                                ? Colors.red // Red for negative values
                                : Colors.green), // Green for positive values
                      ),
                      TextSpan(
                        text: " ", // Adding spaces for width
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      TextSpan(
                        text: "(-22.51%)",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Creates list item for equity holdings showing position details
  /// Used in portfolio/holdings screens to display stock positions with P&L indicators
  static Widget equityScreenTiles(String title, String subtitle, String trail1,
      String trail2, bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 70.h,
            child: Row(
              children: [
                // Vertical color bar indicating positive/negative P&L
                Container(
                    height: 60.h,
                    width: 2.w,
                    color: trail1.startsWith("-") ? Colors.red : Colors.green),
                SizedBox(
                  width: 10.w,
                ),
                // Left column - stock details
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          // subtitle,
                          "Avg.  :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          // subtitle,
                          "1,250",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          // subtitle,
                          "Invt.  :",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          // subtitle,
                          "1,05,832",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                // Right column - P&L and price details
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trail1,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: trail1.startsWith("-")
                              ? Colors.red // Red for negative P&L
                              : Colors.green), // Green for positive P&L
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          // trail2
                          "LTP : ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        Text(
                          "1,731.05 (-1.63%)",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Quantity : ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey : Colors.black),
                        ),
                        Text(
                          "365",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: isDark ? Color(0xFF2f2f2f) : const Color(0xffD1D5DB),
        )
      ],
    );
  }

  /// Creates a standard green action button used across the app
  /// Primary call-to-action button for forms, confirmations, and actions
  static greenButton(String text, {Function? onTap}) {
    return Container(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap != null ? () => onTap() : null,
        child: Text(
          text,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor:
              WidgetStateProperty.all(Color(0xFF1DB954)), // Brand green color
        ),
      ),
    );
  }

  /// Creates a standard text input field with optional phone number validation
  /// Used in forms throughout the app, with specialized handling for phone numbers
  static Widget textField(String hintText, TextEditingController controller,
      {bool isPhoneNumber = false,
      bool isCapital = false,
      required bool isDark}) {
    return TextFormField(
      textCapitalization:
          isCapital ? TextCapitalization.characters : TextCapitalization.none,
      controller: controller,
      keyboardType: isPhoneNumber ? TextInputType.phone : TextInputType.text,
      inputFormatters: isPhoneNumber
          ? [
              FilteringTextInputFormatter
                  .digitsOnly, // Only allow digits for phone numbers
              LengthLimitingTextInputFormatter(
                  10), // Limit to 10 digits for Indian phone numbers
            ]
          : [],
      onChanged: isPhoneNumber
          ? (value) {
              // Validation for Indian phone numbers (must start with 6, 7, 8, or 9)
              if (value.isNotEmpty && !RegExp(r'^[6789]').hasMatch(value)) {
                controller.clear();
                if (navigatorKey.currentContext != null) {
                  ScaffoldMessenger.of(navigatorKey.currentContext!)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        "Phone number must start with 6, 7, 8, or 9",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                      ),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
          : null,
      validator: isPhoneNumber
          ? (value) {
              // Validation logic for phone number fields
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
                return 'Enter a valid 10-digit phone number starting with 6, 7, 8, or 9';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        labelText: hintText,
        labelStyle: TextStyle(
            color: isDark ? const Color(0xffC9CACC) : Color(0xff6B7280)),
        hintStyle: TextStyle(
            color: isDark ? const Color(0xFFC9CACC) : Colors.black,
            fontSize: 15.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
          borderSide: BorderSide(
              color:
                  isDark ? const Color(0xff2F2F2F) : const Color(0xff6B7280)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        // Custom prefix for phone number fields to show country code
        prefixIcon: isPhoneNumber
            ? Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "+91",
                      style: TextStyle(
                          color: isDark
                              ? const Color(0xffC9CACC)
                              : Color(0xff6B7280),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8.w), // Adds spacing
                    Container(
                      width: 1, // Thin vertical line
                      height: 20, // Matches text height
                      color: isDark
                          ? const Color(0xff2F2F2F)
                          : const Color(0xff6B7280),
                    ),
                    SizedBox(width: 8.w), // Adds spacing before text field
                  ],
                ),
              )
            : null,
        prefixIconConstraints:
            isPhoneNumber ? BoxConstraints(minWidth: 20) : null,
      ),
      style: TextStyle(
          color: isDark ? Colors.white : Colors.black, fontSize: 16.sp),
    );
  }

  /// Creates a "Need Help?" button with bottom sheet support options
  /// Used throughout the app to provide access to support resources
  static needHelpButton(BuildContext context) {
    // Helper function to show FAQ bottom sheet with expandable items
    void showFAQBottomSheet(BuildContext context) {
      List<Map<String, String>> faqList = [
        {
          "question": "Is my personal data safe in Sapphire?",
          "answer": "Yes, your data is completely secure."
        },
        {
          "question": "Why do I need to provide my email?",
          "answer": "Your email helps us personalize your experience."
        },
        {
          "question": "Is my personal data safe in Sapphire?",
          "answer": "Yes, your data is completely secure."
        },
        {
          "question": "Why do I need to provide my email?",
          "answer": "Your email helps us personalize your experience."
        },
        {
          "question": "Is my personal data safe in Sapphire?",
          "answer": "Yes, your data is completely secure."
        },
        {
          "question": "Why do I need to provide my email?",
          "answer": "Your email helps us personalize your experience."
        },
      ];

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7, // 50% of screen height
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (_, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Dark background like your screenshot
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: faqList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                ExpansionTile(
                                  tilePadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  title: Text(
                                    faqList[index]['question']!,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Text(
                                        faqList[index]['answer']!,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                    color: Colors.grey.shade800,
                                    height:
                                        1), // Thin separator like your image
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextButton(
          onPressed: () {
            // Show help options in bottom sheet
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(26.r)), // Rounded top corners
              ),
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 15.w), // Padding to match the image
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ensure the height is based on content
                    children: [
                      ListView(
                        shrinkWrap: true, // Prevent infinite height
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling in this ListView
                        children: [
                          // Support Portal option
                          ListTile(
                            leading: SizedBox(
                              height: 25.h,
                              width: 25.h,
                              child: Image.asset(
                                "assets/icons/chat.png",
                                color: Colors
                                    .green, // Green icon to match the image
                              ),
                            ),
                            title: Text(
                              "Support Portal",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            onTap: () {
                              // Handle tap for Support Portal
                              Navigator.pop(context); // Close the bottom sheet
                              // Add navigation or action here
                            },
                          ),
                          Divider(
                              color: isDark(context)
                                  ? const Color(0xff2f2f2f)
                                  : const Color(0xffD1D5DB),
                              thickness: 1), // Divider between items
                          // Contact Us option
                          ListTile(
                            leading: SizedBox(
                                height: 25.h,
                                width: 25.h,
                                child: Image.asset("assets/icons/contact.png")),
                            title: Text(
                              "Contact Us",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            onTap: () {
                              // Handle tap for Contact Us
                              Navigator.pop(context); // Close the bottom sheet
                              // Add navigation or action here
                            },
                          ),
                          Divider(
                              color: isDark(context)
                                  ? const Color(0xff2f2f2f)
                                  : const Color(0xffD1D5DB),
                              thickness: 1), // Divider
                          ListTile(
                            leading: SizedBox(
                                height: 25.h,
                                width: 25.h,
                                child: Image.asset("assets/icons/faq.png")),
                            title: Text(
                              "Frequently Asked Questions",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              // showFAQBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            'Need Help?',
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark(context) ? Colors.white : Colors.black),
          )),
    );
  }

  /// Creates a progress bar for multi-step processes like onboarding/registration
  /// Shows current progress with green bars for completed steps
  static topProgressBar(int index, int filled, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(9, (int i) {
        return Container(
          decoration: BoxDecoration(
            color: i < filled
                ? Colors.green
                : Colors.white, // Green if index < filled, else white
            borderRadius: BorderRadius.circular(5.r),
          ),
          height: 4.h,
          width: 35.w, // Subtract total padding and divide by 9
        );
      }),
    );
  }

  /// Creates a choice chip with checkbox for filter selections
  /// Used in filter UIs and selection screens
  static choiceChipiWithCheckbox(
      String text, bool val, BuildContext context, bool isDark) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Transform.scale(
              scale: 0.8,
              child: CustomCheckbox(
                value: val,
                onChanged: (val) {
                  // You can add logic here if needed
                },
                size: 20.0, // Adjust size as needed
                checkmarkPadding:
                    4, // Adjust padding around the checkmark (e.g., 2.0, 4.0, or 6.0)
              )),
          SizedBox(
            width: 5.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp, // Increased font size to match image
              fontWeight: FontWeight.w400,
              color: isDark
                  ? Colors.white
                  : Colors.black, // White text to match black background
            ),
          ),
        ],
      ),
      height: 45.h,
      width: 167.w, // Maintain half-screen width minus padding
      decoration: BoxDecoration(
        border: Border.all(
          color: val
              ? Colors.green
              : Colors.grey.shade800, // Gray border to match image
          width: 1.5, // Slightly thicker border for visibility
        ),
        borderRadius:
            BorderRadius.circular(8.r), // Larger rounded corners to match image
        color: val
            ? Colors.green.withOpacity(0.2)
            : isDark
                ? Color(0xff121413)
                : Color(0xffF4F4F9), // Black background to match image
      ),
    );
  }

  /// Creates a simple choice chip without checkbox for selection UIs
  /// Used for timeframe selection, order type filters, etc.
  static choiceChip(
      String text, bool val, BuildContext context, double width, bool isDark) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp, // Increased font size to match image
            fontWeight: FontWeight.w400,
            color: isDark
                ? Colors.white
                : Colors.black, // White text to match black background
          ),
        ),
      ),
      height: 36.h,
      width: width, // Maintain half-screen width minus padding
      decoration: BoxDecoration(
        border: Border.all(
          color: val
              ? Colors.green
              : isDark
                  ? Color(0xff2F2F2F)
                  : Color(0xffD1D5DB), // Gray border to match image
          width: 1.5, // Slightly thicker border for visibility
        ),
        borderRadius:
            BorderRadius.circular(3.r), // Larger rounded corners to match image
        color: val
            ? (isDark ? Colors.green.withOpacity(0.2) : Colors.green.shade100)
            : (isDark ? const Color(0xFF121413) : Colors.grey.shade100),
        // Black background to match image
      ),
    );
  }
}

/// CustomCheckbox - A custom implementation of checkbox widget
/// Used for more customizable checkboxes throughout the app UI
/// Provides better control over size, padding, and appearance
class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double size;
  final double checkmarkPadding; // Padding around the checkmark

  const CustomCheckbox({
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.checkmarkPadding = 4.0, // Default padding around checkmark
    super.key,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

/// State class for the CustomCheckbox widget
/// Handles display and interaction for the custom checkbox
class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.value
                  ? Colors.green
                  : Colors.grey
                      .shade800, // Matches 'side: BorderSide(color: Colors.grey.shade800, width: 1)'
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6
                .r), // Matches 'shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))'
            color: Colors.transparent
            // Matches 'activeColor: Colors.green' and 'fillColor: WidgetStateProperty.all(Colors.transparent)'
            ),
        child: widget.value
            ? Padding(
                padding: EdgeInsets.all(
                    widget.checkmarkPadding), // Padding around checkmark
                child: Icon(
                  Icons.check,
                  color: Colors
                      .green, // Matches 'checkColor: Colors.green' (changed to white for better visibility on green background)
                  size: widget.size -
                      (widget.checkmarkPadding *
                          2.4), // Adjust size to fit padding
                ),
              )
            : null,
      ),
    );
  }
}

/// CustomRadioButton - A custom implementation of radio button widget
/// Used to create consistent radio selection UI throughout the app
class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 14.w,
        height: 14.h,
        decoration: isSelected
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
              )
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff2F2F2F), width: 2),
              ), // Blank when not selected
      ),
    );
  }
}

/// CustomTabBar - A custom tab bar widget with animated selection indicator
/// Used to create consistent tab UI across the app
class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final List<String> options;

  const CustomTabBar(
      {required this.tabController, required this.options, Key? key})
      : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

/// State class for the CustomTabBar widget
/// Handles tab selection and animated indicator
class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (mounted) setState(() {}); // Updates UI when tab changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          // Tab options row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.options.length, (index) {
              bool isSelected = widget.tabController.index == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.tabController.animateTo(index);
                  },
                  child: Column(
                    children: [
                      Text(
                        widget.options[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Color(0xff1DB954)
                              : isDark
                                  ? Color(0xffEBEEF5)
                                  : Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Animated underline indicator
          LayoutBuilder(
            builder: (context, constraints) {
              double segmentWidth =
                  constraints.maxWidth / widget.options.length;
              return Stack(
                children: [
                  // Background divider
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB),
                  ),
                  // Animated green indicator
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: widget.tabController.index * segmentWidth,
                    child: Container(
                      height: 2.h,
                      width: segmentWidth,
                      color: Color(0xff1DB954),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
