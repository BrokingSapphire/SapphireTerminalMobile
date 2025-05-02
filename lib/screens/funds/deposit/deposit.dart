// File: deposit.dart
// Description: Funds deposit screen in the Sapphire Trading application.
// This screen allows users to input deposit amounts, select payment methods (UPI/Net Banking), and complete transactions.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For text input formatting
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG image rendering
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// Utility class for number formatting
/// Provides methods to format numbers in Indian number format (with commas)
class NumberUtils {
  /// Formats a number string to Indian number format with commas
  /// Example: 12345678 becomes 1,23,45,678
  static String formatIndianNumber(String number) {
    if (number.isEmpty) {
      return "0";
    }
    int len = number.length;
    if (len <= 3) {
      return number;
    }
    String result = number.substring(len - 3);
    int remainingIndex = len - 3;
    while (remainingIndex > 0) {
      int groupSize = remainingIndex >= 2 ? 2 : remainingIndex;
      int startIndex = remainingIndex - groupSize;
      result = '${number.substring(startIndex, remainingIndex)},$result';
      remainingIndex -= groupSize;
    }
    return result;
  }
}

/// Custom formatter for Indian number system with fixed decimal places
/// Formats input values to follow Indian number formatting with 2 decimal places
class FixedDecimalIndianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters except decimal point
    String newText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Handle empty input
    if (newText.isEmpty) {
      return const TextEditingValue(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Split into integer and decimal parts
    String integerPart = newText.split('.').first;
    String decimalPart = newText.contains('.') && newText.split('.').length > 1
        ? newText.split('.').last
        : '00';

    // Handle leading zeros in integer part
    if (integerPart.isEmpty || integerPart == '0') {
      integerPart = '0';
    } else {
      while (integerPart.startsWith('0') && integerPart.length > 1) {
        integerPart = integerPart.substring(1);
      }
    }

    // Format the integer part with commas
    String formattedInteger = NumberUtils.formatIndianNumber(integerPart);

    // Ensure decimal part is exactly 2 digits
    if (decimalPart.length > 2) decimalPart = decimalPart.substring(0, 2);
    if (decimalPart.isEmpty) {
      decimalPart = '00';
    } else if (decimalPart.length == 1) {
      decimalPart = '${decimalPart}0';
    }

    // Combine integer and decimal parts
    String formattedAmount = decimalPart == '00' && !newText.contains('.')
        ? '$formattedInteger.00'
        : '$formattedInteger.$decimalPart';

    return TextEditingValue(
      text: formattedAmount,
      selection: TextSelection.collapsed(offset: formattedAmount.length),
    );
  }
}

/// fundsAddScreen - Screen for initiating fund deposits to the trading account
/// Provides amount entry via custom keypad, payment method selection, and transaction processing
/// Note: Class name should be capitalized as per Dart conventions (FundsAddScreen)
class fundsAddScreen extends StatefulWidget {
  const fundsAddScreen({super.key});

  @override
  State<fundsAddScreen> createState() => _fundsAddScreenState();
}

/// State class for the fundsAddScreen widget
/// Manages the UI display and validation for fund deposits
class _fundsAddScreenState extends State<fundsAddScreen> {
  String? selectedBank = 'icici'; // Default selected bank
  String amountText = '0.00'; // Default amount text
  late TextEditingController amountController; // Controller for amount input
  TextEditingController upiId =
      TextEditingController(); // Controller for UPI ID input
  bool _isDecimalMode = false; // Flag for decimal input mode
  String _decimalPart = ''; // Stores decimal part during input
  bool _amountInvalid = false; // Flag for invalid amount
  static const int minAmount = 99; // Minimum deposit amount
  static const int maxAmount =
      999999999; // Maximum deposit amount (₹9,99,99,999)

  /// Validates the entered deposit amount
  /// Checks if amount is within allowed min/max range
  /// Returns true if valid, false otherwise
  bool _validateAmount() {
    String amtStr = amountController.text.replaceAll(',', '');
    double amt = double.tryParse(amtStr) ?? 0.0;
    if (amt < minAmount || amt > maxAmount) {
      setState(() {
        _amountInvalid = true;
      });
      return false;
    } else {
      setState(() {
        _amountInvalid = false;
      });
      return true;
    }
  }

  /// Checks if entered amount meets minimum required threshold
  /// Returns true if amount is ≥ 100, false otherwise
  bool _isAmountSufficient() {
    String amtStr = amountController.text.replaceAll(',', '');
    double amt = double.tryParse(amtStr) ?? 0.0;
    return amt >= 100;
  }

  @override
  void initState() {
    super.initState();
    // Initialize the amount text controller
    amountController = TextEditingController(text: amountText);
  }

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    amountController.dispose();
    upiId.dispose();
    super.dispose();
  }

  // List of available bank accounts for deposit
  final List<Map<String, String>> banks = [
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  /// Adds a predefined value to the current amount
  /// Used for quick amount buttons (+5000, +10000, etc.)
  /// Formats the amount with Indian number formatting (commas)
  void _addAmount(int value) {
    String currentText =
        amountController.text.replaceAll(',', '').split('.').first;
    double currentAmount = double.tryParse(currentText) ?? 0.0;
    double newAmount = currentAmount + value;

    // Ensure amount doesn't exceed maximum
    if (newAmount > maxAmount) {
      newAmount = maxAmount.toDouble();
    }

    String integerPart = newAmount.toInt().toString();
    String formattedAmount =
        '${NumberUtils.formatIndianNumber(integerPart)}.00';

    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
      _isDecimalMode = false;
      _decimalPart = '';
      _validateAmount();
    });
  }

  /// Handles keypad digit press
  /// Manages input differently based on whether in decimal mode or not
  void _handleKeypadPress(String input) {
    String currentText =
        amountController.text.replaceAll(',', '').split('.').first;

    // Handle decimal point input
    if (input == '.') {
      if (!_isDecimalMode) {
        setState(() {
          _isDecimalMode = true;
          _decimalPart = '00';
          amountText = '${NumberUtils.formatIndianNumber(currentText)}.00';
          amountController.text = amountText;
        });
      }
      return;
    }

    // Handle input in decimal mode
    if (_isDecimalMode) {
      if (_decimalPart == '00') {
        _decimalPart = '${input}0';
      } else if (_decimalPart.length == 2) {
        _decimalPart = _decimalPart[0] + input;
      }
      setState(() {
        amountText =
            '${NumberUtils.formatIndianNumber(currentText)}.$_decimalPart';
        amountController.text = amountText;
      });
    }
    // Handle input in normal (integer) mode
    else {
      String newText = currentText == '0' ? input : currentText + input;
      if (int.tryParse(newText) != null && int.parse(newText) <= maxAmount) {
        String formattedAmount =
            '${NumberUtils.formatIndianNumber(newText)}.00';
        setState(() {
          amountText = formattedAmount;
          amountController.text = formattedAmount;
        });
      }
    }
  }

  /// Ensures decimal part is properly formatted before proceeding
  /// Formats amount as "integer.decimal" with exactly 2 decimal places
  void _addDecimalPart() {
    String currentText = amountController.text.replaceAll(',', '');
    String integerPart = currentText.split('.').first;
    String decimalPart = _isDecimalMode ? _decimalPart : '00';

    if (_isDecimalMode && decimalPart.isEmpty) {
      decimalPart = '00';
      integerPart = integerPart.isEmpty ? '0' : integerPart;
    }

    String formattedInteger = NumberUtils.formatIndianNumber(integerPart);
    String formattedAmount = '$formattedInteger.$decimalPart';

    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
      _isDecimalMode = false;
      _decimalPart = '';
    });
  }

  /// Handles backspace press on the custom keypad
  /// Removes the last digit and reformats the amount
  void _handleBackspace() {
    String currentText = amountController.text.replaceAll(',', '');
    String integerPart = currentText.split('.').first;

    // If in decimal mode, exit decimal mode entirely
    if (_isDecimalMode) {
      setState(() {
        _isDecimalMode = false;
        _decimalPart = '';
        amountText =
            '${NumberUtils.formatIndianNumber(integerPart.isEmpty ? '0' : integerPart)}.00';
        amountController.text = amountText;
      });
    }
    // If in integer mode, remove last digit
    else {
      if (integerPart.length <= 1) {
        integerPart = '0';
      } else {
        integerPart = integerPart.substring(0, integerPart.length - 1);
      }
      String formattedAmount =
          '${NumberUtils.formatIndianNumber(integerPart)}.00';
      setState(() {
        amountText = formattedAmount;
        amountController.text = formattedAmount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final bool isAmountValid = _isAmountSufficient() && !_amountInvalid;

    return Scaffold(
      backgroundColor: backgroundColor,
      // App bar with back button and available balance
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 32.w,
        leading: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
            icon: Icon(Icons.arrow_back, color: textColor),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            'Deposit',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: textColor,
            ),
          ),
        ),
        // Display available balance in the app bar
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Text(
              "Avl. Balance :",
              style: TextStyle(
                fontSize: 13.sp,
                color:
                    isDark ? const Color(0xffC9CACC) : const Color(0xff6B7280),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Text(
              "₹ 2,532.00",
              style: TextStyle(
                fontSize: 13.sp,
                color: isDark ? Colors.white : const Color(0xff1A1A1A),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
          Divider(
              color:
                  isDark ? const Color(0xff2F2F2F) : const Color(0xffD1D5DB)),
          SizedBox(height: 50.h),

          // Amount input field with Rupee symbol
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: TextField(
                              controller: amountController,
                              readOnly:
                                  true, // Use custom keypad instead of system keyboard
                              enableInteractiveSelection: false,
                              showCursor: false,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: amountController.text == "0.00"
                                    ? const Color(
                                        0xffC9CACC) // Gray for empty/zero amounts
                                    : _amountInvalid
                                        ? Colors.red // Red for invalid amounts
                                        : textColor, // Default text color
                                overflow: TextOverflow.ellipsis,
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '0.00',
                                hintStyle: TextStyle(
                                  color: textColor.withOpacity(0.5),
                                  fontSize: 32.sp,
                                ),
                                isCollapsed: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              maxLines: 1,
                              inputFormatters: [FixedDecimalIndianFormatter()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 28.h),

          // Quick Amount Buttons for fast amount selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmountButton('+₹5,000', isDark, () => _addAmount(5000)),
              SizedBox(width: 24.w),
              _buildAmountButton('+₹10,000', isDark, () => _addAmount(10000)),
              SizedBox(width: 24.w),
              _buildAmountButton('+₹20,000', isDark, () => _addAmount(20000)),
            ],
          ),
          const Spacer(),

          // Bank Account Selection Widget
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff121413) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isDark ? const Color(0xff2F2F2F) : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icici.png",
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ICICI Bank',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          'XXXX XXXX 6485',
                          style: TextStyle(
                            color: isDark ? Colors.grey : Colors.grey.shade700,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: textColor,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),

          // Custom Number Keypad for amount entry
          _buildNumberKeypad(isDark),

          // Continue Button - enabled only when amount is valid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    isAmountValid
                        ? const Color(0xFF00C853) // Green when amount is valid
                        : const Color(
                            0xff2f2f2f), // Gray when amount is invalid
                  ),
                  foregroundColor: isAmountValid
                      ? WidgetStatePropertyAll(Colors.white)
                      : WidgetStatePropertyAll(Color(0xffc9cacc)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                ),
                onPressed: isAmountValid
                    ? () {
                        _addDecimalPart();
                        if (_validateAmount()) {
                          _selectPaymentMethod(
                              context, isDark, amountController.text);
                        }
                      }
                    : null, // Disable button when amount isn't valid
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the custom number keypad for amount entry
  /// Provides digits 0-9, decimal point, and backspace
  Widget _buildNumberKeypad(bool isDark) {
    final textColor = const Color(0xFF1DB954);

    /// Helper method to build individual keypad buttons
    Widget _buildKeypadButton(String text,
        {VoidCallback? onPressed, Color? color, IconData? icon}) {
      return Expanded(
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.r),
          splashColor: Colors.green.withOpacity(0.2),
          child: Container(
            height: 60.h,
            alignment: Alignment.center,
            child: icon != null
                ? Icon(icon, color: color ?? textColor, size: 24.sp)
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: color ?? textColor,
                    ),
                  ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          // First row of keypad (1, 2, 3)
          Row(
            children: [
              _buildKeypadButton('1', onPressed: () => _handleKeypadPress('1')),
              _buildKeypadButton('2', onPressed: () => _handleKeypadPress('2')),
              _buildKeypadButton('3', onPressed: () => _handleKeypadPress('3')),
            ],
          ),
          // Second row of keypad (4, 5, 6)
          Row(
            children: [
              _buildKeypadButton('4', onPressed: () => _handleKeypadPress('4')),
              _buildKeypadButton('5', onPressed: () => _handleKeypadPress('5')),
              _buildKeypadButton('6', onPressed: () => _handleKeypadPress('6')),
            ],
          ),
          // Third row of keypad (7, 8, 9)
          Row(
            children: [
              _buildKeypadButton('7', onPressed: () => _handleKeypadPress('7')),
              _buildKeypadButton('8', onPressed: () => _handleKeypadPress('8')),
              _buildKeypadButton('9', onPressed: () => _handleKeypadPress('9')),
            ],
          ),
          // Fourth row of keypad (., 0, backspace)
          Row(
            children: [
              _buildKeypadButton('.', onPressed: () => _handleKeypadPress('.')),
              _buildKeypadButton('0', onPressed: () => _handleKeypadPress('0')),
              _buildKeypadButton('',
                  icon: Icons.backspace_outlined,
                  color: const Color(0xFF00C853),
                  onPressed: _handleBackspace),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a quick amount selection button
  /// Used for quickly adding common amounts to the deposit
  Widget _buildAmountButton(String text, bool isDark, VoidCallback onPressed) {
    return Container(
      height: 34.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? const Color(0xff121413) : const Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isDark ? const Color(0xff2F2F2F) : Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  /// Opens payment method selection bottom sheet
  /// Displays UPI options, UPI ID input, and Net Banking option
  void _selectPaymentMethod(BuildContext context, bool isDark, String amount) {
    double parsedAmount = double.tryParse(amount.replaceAll(',', '')) ?? 0.0;
    bool isAboveTwoLakh = parsedAmount >
        200000; // Check if amount exceeds ₹2 lakh (for potential regulatory requirements)

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
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
              // Header row with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: isDark ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              // UPI payment options row (PhonePe, GPay, PayTM)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // PhonePe option
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/phonepe.png',
                          height: 42.h,
                          width: 42.w,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "PhonePe",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // GPay option
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/gpay.png',
                          height: 42.h,
                          width: 42.w,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "GPay",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PayTM option
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/paytm.png',
                          height: 42.h,
                          width: 42.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "PayTM",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // OR separator
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? const Color(0xff2F2F2F)
                          : const Color(0xffD1D5DB),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      "OR",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? const Color(0xff2F2F2F)
                          : const Color(0xffD1D5DB),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // UPI ID input field
              TextField(
                controller: upiId,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xff2F2F2F)
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  hintText: "Enter UPI ID",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: isDark
                        ? const Color(0xffC9CACC)
                        : const Color(0xff6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Net Banking option
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff121413)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color:
                        isDark ? const Color(0xff2F2F2F) : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/netbanking logo.png",
                    width: 24.w,
                    height: 24.h,
                  ),
                  title: Text(
                    'Net Banking',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: isDark ? Colors.white : Colors.black,
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Confirm deposit button
              constWidgets.greenButton(
                "Add ${amountController.text}",
                onTap: () {
                  // TODO: Implement deposit transaction processing
                  // Close bottom sheet and navigate to confirmation/status screen
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 15.h),
            ],
          ),
        );
      },
    );
  }
}
