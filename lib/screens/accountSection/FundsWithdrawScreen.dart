import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constWidgets.dart';

class fundsWithdrawScreen extends StatefulWidget {
  const fundsWithdrawScreen({super.key});

  @override
  State<fundsWithdrawScreen> createState() => _fundsWithdrawScreenState();
}

class _fundsWithdrawScreenState extends State<fundsWithdrawScreen> {
  String? selectedBank = 'icici';
  String amountText = '0.00';
  late TextEditingController amountController;
  bool _amountInvalid = false;
  bool _isInstant = true;
  static const int minAmount = 100;
  static const int maxAmount = 9999999999; // 99,99,99,999 as integer

  final List<Map<String, String>> banks = [
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

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

  void _addAmount(int value) {
    String currentText = amountController.text.replaceAll(',', '');
    double currentAmount = double.tryParse(currentText) ?? 0.0;
    double newAmount = currentAmount + value;
    String newAmountStr = newAmount.toStringAsFixed(2);
    String integerPart = newAmountStr.split('.')[0];
    String decimalPart = newAmountStr.split('.')[1];
    String formattedAmount = '';
    int len = integerPart.length;
    if (len <= 3) {
      formattedAmount = integerPart;
    } else {
      formattedAmount = integerPart.substring(len - 3);
      int remaining = len - 3;
      int pos = remaining;
      while (pos > 0) {
        int groupSize = 2;
        if (pos < 2) groupSize = pos;
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

  void _handleKeypadPress(String digit) {
    String currentText = amountController.text.replaceAll(',', '');
    if (currentText == '0' || currentText == '0.00' || currentText.isEmpty) {
      currentText = digit;
    } else {
      currentText = currentText + digit;
    }
    String formattedAmount = formatIndianNumber(currentText);
    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
    });
  }

  void _addDecimalPart() {
    String currentText = amountController.text.replaceAll(',', '');
    if (currentText.isEmpty) currentText = '0';
    String integerPart = currentText;
    String decimalPart = '00';
    if (currentText.contains('.')) {
      var parts = currentText.split('.');
      integerPart = parts[0];
      decimalPart = parts.length > 1 ? parts[1] : '00';
      if (decimalPart.length > 2) decimalPart = decimalPart.substring(0, 2);
      if (decimalPart.length < 2) decimalPart = decimalPart.padRight(2, '0');
    }
    String formattedInteger = formatIndianNumber(integerPart);
    setState(() {
      amountText = formattedInteger + '.' + decimalPart;
      amountController.text = amountText;
    });
  }

  String formatIndianNumber(String number) {
    if (number.isEmpty) return "0";
    String integerPart = number.split('.')[0];
    int len = integerPart.length;
    if (len <= 3) return integerPart;
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

  void _handleBackspace() {
    String currentText = amountController.text.replaceAll(',', '');
    if (currentText.length <= 1) {
      currentText = '0';
    } else {
      currentText = currentText.substring(0, currentText.length - 1);
    }
    String formattedAmount = formatIndianNumber(currentText);
    setState(() {
      amountText = formattedAmount;
      amountController.text = formattedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black)),
        ),
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
              '  ₹ 12,532.00',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                                        enableInteractiveSelection: false,
                                        showCursor: false,
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              (amountController.text == "0" ||
                                                      amountController.text ==
                                                          "0.00")
                                                  ? Color(0xffC9CACC)
                                                  : (_amountInvalid
                                                      ? Colors.red
                                                      : textColor),
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
                    // Quick Amount Buttons
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

                    // Instant / Regular
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
                    // SizedBox(height: 34.h),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF2F2708) : Color(0xFFFEF8E5),
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
                    Container(
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

                    // Custom Keypad
                    _buildNumberKeypad(),

                    // Withdraw Button
                    ElevatedButton(
                      onPressed: () {
                        _addDecimalPart();
                        if (_validateAmount()) {
                          // TODO: Add your withdraw logic here
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00C853),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Info box

                    SizedBox(height: 15.h),

                    // Proceed button
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

  // Quick Amount Button
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

  // Bank Tile
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
              color:
                  selectedBank == value ? Colors.green : Colors.grey.shade700,
              width: 2.5.w,
            ),
            color: selectedBank == value ? Colors.green : Colors.transparent,
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
        ),
      ),
    );
  }

  // Custom Number Keypad
  Widget _buildNumberKeypad() {
    final textColor = Color(0xFF1DB954);

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
}
