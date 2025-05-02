// File: withdrawal.dart
// Description: Funds withdrawal screen in the Sapphire Trading application.
// This screen allows users to input and confirm withdrawal amounts, select withdrawal method, and choose bank accounts.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For text input formatting
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG image rendering

import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:sapphire/screens/funds/bankSelectionPopup.dart'; // Bank selection bottom sheet

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

/// fundsWithdrawScreen - Screen for initiating fund withdrawals from the trading account
/// Provides amount entry via custom keypad, withdrawal method selection, and bank account selection
/// Note: Class name should be capitalized as per Dart conventions (FundsWithdrawScreen)
class fundsWithdrawScreen extends StatefulWidget {
  const fundsWithdrawScreen({super.key});

  @override
  State<fundsWithdrawScreen> createState() => _fundsWithdrawScreenState();
}

/// State class for the fundsWithdrawScreen widget
/// Manages the UI display and validation for fund withdrawals
class _fundsWithdrawScreenState extends State<fundsWithdrawScreen> {
  String? selectedBank =
      'bank_0'; // Default selected bank (first bank in the list)
  String amountText = '0.00'; // Default amount text
  late TextEditingController amountController; // Controller for amount input
  bool _amountInvalid = false; // Flag for invalid amount
  bool _isInstant = true; // Flag for instant withdrawal (vs regular)
  bool _isDecimalMode = false; // Flag for decimal input mode
  String _decimalPart = ''; // Stores decimal part during input
  static const int minAmount = 100; // Minimum withdrawal amount
  static const int maxAmount =
      12532; // Maximum withdrawal amount (99,99,99,999)

  // List of available bank accounts for withdrawal
  final List<Map<String, String>> banks = [
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the amount text controller
    amountController = TextEditingController(text: amountText);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    amountController.dispose();
    super.dispose();
  }

  /// Validates the entered withdrawal amount
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
        _validateAmount();
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
          _validateAmount();
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

    // Validate the amount
    _validateAmount();

    if (_isDecimalMode && decimalPart.isEmpty) {
      decimalPart = '00';
      integerPart = integerPart.isEmpty ? '0' : integerPart;
    }

    String formattedAmount = '$integerPart.$decimalPart';
    formattedAmount =
        '${NumberUtils.formatIndianNumber(integerPart)}.$decimalPart';

    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
      _isDecimalMode = false;
      _decimalPart = '';
      _validateAmount();
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

    // Create gradient for visual elements (not currently used but available)
    final Shader linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xffFF9E42), // Orange
        Color(0xfffffd94), // Yellow
        Color(0xffFF5722), // Red-Orange for contrast
      ],
      stops: [
        0.0,
        0.5,
        1.0
      ], // Adding a stop in the middle for a smoother gradient
    ).createShader(Rect.fromLTWH(
        0.0, 0.0, 300.0, 70.0)); // Increased size for better visibility

    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      // App bar with back button and withdrawable amount display
      appBar: AppBar(
        leadingWidth: 32.w,
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Withdraw',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black)),
        ),
        // Display withdrawable amount in the app bar
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18, right: 5),
            child: Text(
              'Wdl. amount :',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? Colors.white70 : Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, right: 10),
            child: Text(
              NumberUtils.formatIndianNumber(maxAmount.toString()) + '.00',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),

                    // Amount input field with Rupee symbol
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                                        readOnly: true,
                                        // Use custom keypad instead of system keyboard
                                        enableInteractiveSelection: false,
                                        showCursor: false,
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w600,
                                          color: (amountController.text ==
                                                      "0" ||
                                                  amountController.text ==
                                                      "0.00")
                                              ? Color(
                                                  0xffC9CACC) // Gray for zero/empty
                                              : (_amountInvalid
                                                  ? Colors
                                                      .red // Red for invalid amounts
                                                  : textColor),
                                          // Default text color
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            color: textColor.withOpacity(0.5),
                                            fontSize: 32.sp,
                                          ),
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Quick Amount Buttons for fast amount selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAmountButton(
                            '+₹5,000', () => _addAmount(5000), isDark),
                        SizedBox(width: 24.w),
                        _buildAmountButton(
                            '+₹10,000', () => _addAmount(10000), isDark),
                        SizedBox(width: 24.w),
                        _buildAmountButton(
                            '+₹20,000', () => _addAmount(20000), isDark),
                      ],
                    ),
                    SizedBox(height: 28.h),

                    // Withdrawal Method Selection (Instant/Regular)
                    Container(
                      height: 60.h,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Instant withdrawal option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isInstant = true;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  _isInstant
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color:
                                      _isInstant ? Colors.green : Colors.grey,
                                ),
                                SizedBox(width: 6.w),
                                SvgPicture.asset(
                                  'assets/svgs/instant.svg',
                                ),
                                Text("⚡️")
                              ],
                            ),
                          ),
                          SizedBox(width: 30.w),
                          // Regular withdrawal option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isInstant = false;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  !_isInstant
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: !_isInstant
                                      ? Colors.green
                                      : isDark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Regular",
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // Withdrawal timing information notice
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Color(0xFF2F2708)
                            : Color(0xFFFEF8E5), // Amber background
                        border: Border.all(
                            color:
                                isDark ? Color(0xFFB58E00) : Color(0xFFD1D5DB),
                            width: 1.w),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Withdrawal requests between 5:00 AM and 5:00 PM are credited the same day. "
                        "Requests placed after 5:00 PM and before 5:00 AM are processed the next working day.",
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Bank Selection Container - Opens bottom sheet on tap
                    GestureDetector(
                      onTap: () => _openBankSelectionSheet(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xff121413)
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xff2F2F2F)
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                selectedBank == 'bank_1'
                                    ? "assets/images/kotak.png"
                                    : "assets/images/icici.png",
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
                                      _getSelectedBankName(),
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      _getSelectedBankAccountNumber(),
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.grey
                                            : Colors.grey.shade700,
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
                    ),

                    // Custom Number Keypad for amount entry
                    _buildNumberKeypad(),
                    SizedBox(height: 15.h),

                    // Bank Account Selection Widget

                    // Custom Number Keypad for amount entry
                    // _buildNumberKeypad(),

                    // Withdraw Action Button
                    ElevatedButton(
                      onPressed: () {
                        _addDecimalPart(); // Ensure decimal formatting is correct
                        if (_validateAmount()) {
                          // TODO: Add your withdraw logic here
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (() {
                          String amtStr =
                              amountController.text.replaceAll(',', '');
                          double amt = double.tryParse(amtStr) ?? 0.0;
                          return (amt < minAmount || amt > maxAmount)
                              ? Color(0xff2f2f2f)
                              : Color(0xFF00C853);
                        })(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                          color: (() {
                            String amtStr =
                                amountController.text.replaceAll(',', '');
                            double amt = double.tryParse(amtStr) ?? 0.0;
                            return (amt < minAmount || amt > maxAmount)
                                ? Color(0xffc9cacc)
                                : Colors.white;
                          })(),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // Note: The following buttons are commented out in the original code
                    // constWidgets.greenButton("Proceed"),
                    // SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a quick amount selection button
  /// Used for quickly adding common amounts to the withdrawal
  Widget _buildAmountButton(String text, VoidCallback onPressed, bool isDark) {
    return Container(
      height: 34.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
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

  /// Creates a bank account selection tile
  /// Shows bank logo, name, account number and selection status
  Widget _buildBankTile(
      String bankName, String accountNumber, String iconPath, String value) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            selectedBank = value;
          });
        },
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            trailing: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedBank == value
                      ? Colors.green
                      : Colors.grey.shade700,
                  width: 2.5.w,
                ),
                color:
                    selectedBank == value ? Colors.green : Colors.transparent,
              ),
              child: selectedBank == value
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : null,
            ),
            title: Row(
              children: [
                Image.asset(iconPath, height: 30.h, width: 30.w),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bankName,
                        style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                    Text(accountNumber,
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
                  ],
                ),
              ],
            )));
  }

  /// Opens the bank selection bottom sheet
  /// Uses the centralized bottom sheet component
  void _openBankSelectionSheet(BuildContext context) {
    showBankSelectionBottomSheet(
      context: context,
      banks: banks,
      selectedBank: selectedBank,
      onBankSelected: (String bankId) {
        setState(() {
          selectedBank = bankId;
        });
      },
    );
  }

  /// Gets the name of the currently selected bank
  /// Returns the bank name based on the selectedBank value
  String _getSelectedBankName() {
    if (selectedBank == 'bank_1') {
      return 'Kotak Mahindra Bank';
    }

    // For all other cases, return ICICI Bank
    return 'ICICI Bank';
  }

  /// Gets the account number of the currently selected bank
  /// Returns the masked account number based on the selectedBank value
  String _getSelectedBankAccountNumber() {
    final int index = int.tryParse(selectedBank?.split('_').last ?? '0') ?? 0;
    if (index < banks.length) {
      return banks[index]['details'] ?? '';
    }
    return '';
  }

  /// Builds the custom number keypad for amount entry
  /// Provides digits 0-9, decimal point, and backspace
  Widget _buildNumberKeypad() {
    final textColor = Color(0xFF1DB954); // Green color for keypad

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
                  color: Color(0xFF00C853),
                  onPressed: _handleBackspace),
            ],
          ),
        ],
      ),
    );
  }
}
