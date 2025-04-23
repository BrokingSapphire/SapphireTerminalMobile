import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

// Custom formatter for Indian number system and fixed .00
class FixedDecimalIndianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-numeric characters
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If empty, return 0
    if (newText.isEmpty) {
      return TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    // Remove leading zeros
    while (newText.startsWith('0') && newText.length > 1) {
      newText = newText.substring(1);
    }

    // Format using Indian number system
    String formattedAmount = formatIndianNumber(newText);

    // Set cursor position
    int selectionIndex = formattedAmount.length;

    return TextEditingValue(
      text: formattedAmount,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  // Format numbers according to Indian number system (1,00,000)
  String formatIndianNumber(String number) {
    // Handle empty or null strings
    if (number.isEmpty) {
      return "0";
    }

    int len = number.length;

    // If 3 or fewer digits, no commas needed
    if (len <= 3) {
      return number;
    }

    // For Indian number system: first group of 3 digits from right, then groups of 2 digits
    String result = number.substring(len - 3); // Last 3 digits
    int remainingIndex = len - 3;

    while (remainingIndex > 0) {
      // Take 2 digits (or whatever is left if less than 2)
      int groupSize = remainingIndex >= 2 ? 2 : remainingIndex;
      int startIndex = remainingIndex - groupSize;

      // Add comma and the group
      result = number.substring(startIndex, remainingIndex) + "," + result;

      // Move index back
      remainingIndex -= groupSize;
    }

    return result;
  }
}

class FundsAddScreen extends StatefulWidget {
  const FundsAddScreen({super.key});

  @override
  State<FundsAddScreen> createState() => _FundsAddScreenState();
}

class _FundsAddScreenState extends State<FundsAddScreen> {
  String? selectedBank = 'icici'; // Default selected bank
  String amountText = '0.00';
  late TextEditingController amountController;
  TextEditingController upiId = TextEditingController();

  // Validation state
  bool _amountInvalid = false;
  static const int minAmount = 100;
  static const int maxAmount = 9999999999; // 99,99,99,999 as integer

  /// Returns true if amount is valid, else sets _amountInvalid and returns false
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

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: amountText);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> banks = [
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  // Add amount based on button press
  void _addAmount(int value) {
    // Parse current amount without commas
    String currentText = amountController.text.replaceAll(',', '');
    double currentAmount = double.tryParse(currentText) ?? 0.0;

    // Add the new value
    double newAmount = currentAmount + value;

    // Format with Indian number system
    String newAmountStr = newAmount.toStringAsFixed(2);
    String integerPart = newAmountStr.split('.')[0];
    String decimalPart = newAmountStr.split('.')[1];

    // Format using Indian number system (1,00,000 for 1 lakh, etc.)
    String formattedAmount = '';
    int len = integerPart.length;

    // Indian number system: first group of 3 digits, then groups of 2 digits
    if (len <= 3) {
      // If less than 1000, no commas needed
      formattedAmount = integerPart;
    } else {
      // First add the last 3 digits
      formattedAmount = integerPart.substring(len - 3);

      // Then add groups of 2 digits with commas
      int remaining = len - 3;
      int pos = remaining;

      while (pos > 0) {
        int groupSize = 2;
        if (pos < 2) {
          groupSize = pos; // Handle remaining single digit
        }

        formattedAmount =
            integerPart.substring(pos - groupSize, pos) + "," + formattedAmount;
        pos -= groupSize;
      }
    }

    setState(() {
      amountText = formattedAmount + '.' + decimalPart;
      amountController.text = amountText;
    });
  }

  // These methods are no longer needed since we removed the keypad
  // All input handling is done by the FixedDecimalIndianFormatter

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: textColor),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            'Deposit',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15.sp, color: textColor),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Text(
              "Avl. Balance :",
              style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(width: 5.w),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Text(
              "₹ 2,532.00",
              style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Colors.white : Color(0xff1A1A1A),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
          Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
          SizedBox(height: 50.h),
          // Amount Display TextField
          // Amount Display: Rupee sign and amount are visually centered
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
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: TextField(
                                controller: amountController,
                                readOnly: true,
                                enableInteractiveSelection: false,
                                showCursor: false,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _amountInvalid ? Colors.red : textColor,
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
                                    fontSize: 40.sp,
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ),

          SizedBox(height: 20.h),
          // Amount Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmountButton('+₹5,000', isDark, () => _addAmount(5000)),
              SizedBox(width: 10.w),
              _buildAmountButton('+₹10,000', isDark, () => _addAmount(10000)),
              SizedBox(width: 10.w),
              _buildAmountButton('+₹20,000', isDark, () => _addAmount(20000)),
            ],
          ),
          // SizedBox(height: 60.h),
          Spacer(),

          // Bank Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: isDark ? Color(0xff121413) : Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isDark ? Color(0xff2F2F2F) : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: ListTile(
              leading: Image.asset("assets/images/icici.png",
                  width: 24.w, height: 24.h),
              title: Text(
                'ICICI Bank',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.sp,
                ),
              ),
              subtitle: Text(
                'XXXX XXXX 6485',
                style: TextStyle(
                  color: isDark ? Colors.grey : Colors.grey.shade700,
                  fontSize: 12.sp,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: textColor,
                size: 16.sp,
              ),
            ),
          ),

          // Number Keypad
          _buildNumberKeypad(isDark),
          // Continue Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: ElevatedButton(
              onPressed: () {
                // Handle continue pressed
                _addDecimalPart(); // Add decimal part when continuing
                if (_validateAmount()) {
                  _selectPaymentMethod(context, isDark, amountController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C853), // Green color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberKeypad(bool isDark) {
    final textColor = Color(0xFF1DB954);

    /// Builds a single button for the custom virtual keypad.
    /// Uses InkWell for Material ripple effect on tap.
    Widget _buildKeypadButton(String text,
        {VoidCallback? onPressed, Color? color, IconData? icon}) {
      return Expanded(
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.r), // Rounded ripple
          splashColor: Colors.green.withOpacity(0.2), // Custom ripple color
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
          Row(
            children: [
              _buildKeypadButton('1', onPressed: () => _handleKeypadPress('1')),
              _buildKeypadButton('2', onPressed: () => _handleKeypadPress('2')),
              _buildKeypadButton('3', onPressed: () => _handleKeypadPress('3')),
            ],
          ),
          Row(
            children: [
              _buildKeypadButton('4', onPressed: () => _handleKeypadPress('4')),
              _buildKeypadButton('5', onPressed: () => _handleKeypadPress('5')),
              _buildKeypadButton('6', onPressed: () => _handleKeypadPress('6')),
            ],
          ),
          Row(
            children: [
              _buildKeypadButton('7', onPressed: () => _handleKeypadPress('7')),
              _buildKeypadButton('8', onPressed: () => _handleKeypadPress('8')),
              _buildKeypadButton('9', onPressed: () => _handleKeypadPress('9')),
            ],
          ),
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

  Widget _buildAmountButton(String text, bool isDark, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? Color(0xff121413) : Color(0xFFF5F5F5),
        // foregroundColor: isDark ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // Widget _buildAmountButton(String text, bool isDark, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: isDark ? Color(0xff121413) : Color(0xFFF5F5F5),
  //       foregroundColor: isDark ? Colors.white : Colors.black,
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //           color: isDark ? Color(0xff2F2F2F) : Colors.grey.shade300,
  //           width: 1,
  //         ),
  //         borderRadius: BorderRadius.circular(8.r),
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
  //     ),
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontSize: 14.sp,
  //         color: isDark ? Colors.white : Colors.black,
  //       ),
  //     ),
  //   );
  // }

  // Handle keypad button press
  /// Handles a digit tap on the custom keypad.
  /// If the current value is '0', '0.00', or empty, replace it with the tapped digit.
  void _handleKeypadPress(String digit) {
    // Get current amount without commas and decimals
    String currentText = amountController.text.replaceAll(',', '');

    // If the current text is '0', '0.00', or empty, start fresh with the digit
    if (currentText == '0' || currentText == '0.00' || currentText.isEmpty) {
      currentText = digit;
    } else {
      // Otherwise, append the digit
      currentText = currentText + digit;
    }

    // Format with Indian number system
    String formattedAmount = formatIndianNumber(currentText);

    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
    });
  }

  // Add decimal part if missing (used in onEditingComplete and Continue button)
  /// Ensures the amount has a decimal part and is formatted with Indian-style commas.
  void _addDecimalPart() {
    String currentText = amountController.text.replaceAll(',', '');
    if (currentText.isEmpty) {
      currentText = '0';
    }
    String integerPart = currentText;
    String decimalPart = '00';

    // If already contains decimal, split and format
    if (currentText.contains('.')) {
      var parts = currentText.split('.');
      integerPart = parts[0];
      decimalPart = parts.length > 1 ? parts[1] : '00';
      // Limit decimal part to 2 digits
      if (decimalPart.length > 2) decimalPart = decimalPart.substring(0, 2);
      if (decimalPart.length < 2) decimalPart = decimalPart.padRight(2, '0');
    }
    // Format integer part with Indian commas
    String formattedInteger = formatIndianNumber(integerPart);

    setState(() {
      amountText = formattedInteger + '.' + decimalPart;
      amountController.text = amountText;
    });
  }

  // Format numbers according to Indian number system (1,00,000)
  String formatIndianNumber(String number) {
    if (number.isEmpty) {
      return "0";
    }
    // Remove any decimal part for formatting
    String integerPart = number.split('.')[0];
    int len = integerPart.length;
    if (len <= 3) {
      return integerPart;
    }
    String result = integerPart.substring(len - 3);
    int remainingIndex = len - 3;
    while (remainingIndex > 0) {
      int groupSize = remainingIndex >= 2 ? 2 : remainingIndex;
      int startIndex = remainingIndex - groupSize;
      result = integerPart.substring(startIndex, remainingIndex) + "," + result;
      remainingIndex -= groupSize;
    }
    return result;
  }

  // Handle backspace press
  void _handleBackspace() {
    // Get current amount without commas
    String currentText = amountController.text.replaceAll(',', '');

    // Remove the last digit
    if (currentText.length <= 1) {
      currentText = '0';
    } else {
      currentText = currentText.substring(0, currentText.length - 1);
    }

    // Format with Indian number system
    String formattedAmount = formatIndianNumber(currentText);

    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
    });
  }

  void _selectPaymentMethod(BuildContext context, bool isDark, String amount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? Color(0xff121413) : Colors.white,
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
                  Text("Select Payment Method",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black)),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: isDark ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              // Adding the three payment options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/phonepe.png',
                            height: 48.h,
                            width: 48.w,
                          ),
                          SizedBox(height: 1.h),
                          Text("PhonePe",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black))
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/gpay.png', // Replace with your Google Pay logo asset
                          height: 48.h,
                          width: 48.w,
                        ),
                        SizedBox(height: 1.h),
                        Text("GPay",
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/paytm.png', // Replace with your PayTM logo asset
                          height: 48.h,
                          width: 48.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 1.h),
                        Text("PayTM",
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xff2f2f2f)
                          : const Color(0xffD1D5DB),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "OR",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xff2f2f2f)
                          : const Color(0xffD1D5DB),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              constWidgets.textField("UPI ID", upiId, isDark: isDark),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff121413) : Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isDark ? Color(0xff2F2F2F) : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  leading: Image.asset("assets/images/netbanking logo.png",
                      width: 24.w, height: 24.h),
                  title: Text(
                    'Net Banking',
                    style: TextStyle(
                      // color: textColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: textColor,
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              constWidgets.greenButton("Add ${amountController.text}",
                  onTap: () {}),
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
