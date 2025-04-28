import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

// Utility class for number formatting
class NumberUtils {
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

// Custom formatter for Indian number system
class FixedDecimalIndianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
    if (newText.isEmpty) {
      return const TextEditingValue(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }
    String integerPart = newText.split('.').first;
    String decimalPart = newText.contains('.') && newText.split('.').length > 1
        ? newText.split('.').last
        : '00';
    if (integerPart.isEmpty || integerPart == '0') {
      integerPart = '0';
    } else {
      while (integerPart.startsWith('0') && integerPart.length > 1) {
        integerPart = integerPart.substring(1);
      }
    }
    String formattedInteger = NumberUtils.formatIndianNumber(integerPart);
    if (decimalPart.length > 2) decimalPart = decimalPart.substring(0, 2);
    if (decimalPart.isEmpty) {
      decimalPart = '00';
    } else if (decimalPart.length == 1) {
      decimalPart = '${decimalPart}0';
    }
    String formattedAmount = decimalPart == '00' && !newText.contains('.')
        ? '$formattedInteger.00'
        : '$formattedInteger.$decimalPart';
    return TextEditingValue(
      text: formattedAmount,
      selection: TextSelection.collapsed(offset: formattedAmount.length),
    );
  }
}

class fundsAddScreen extends StatefulWidget {
  const fundsAddScreen({super.key});

  @override
  State<fundsAddScreen> createState() => _fundsAddScreenState();
}

class _fundsAddScreenState extends State<fundsAddScreen> {
  String? selectedBank = 'icici';
  String amountText = '0.00';
  late TextEditingController amountController;
  TextEditingController upiId = TextEditingController();
  bool _isDecimalMode = false;
  String _decimalPart = '';
  bool _amountInvalid = false;
  static const int minAmount = 99;
  static const int maxAmount = 999999999; // ₹9,99,99,999

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

  bool _isAmountSufficient() {
    String amtStr = amountController.text.replaceAll(',', '');
    double amt = double.tryParse(amtStr) ?? 0.0;
    return amt >= 100;
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: amountText);
  }

  @override
  void dispose() {
    amountController.dispose();
    upiId.dispose();
    super.dispose();
  }

  final List<Map<String, String>> banks = [
    {'name': 'ICICI Bank', 'details': 'XXXX XXXX 6485'},
  ];

  void _addAmount(int value) {
    String currentText =
        amountController.text.replaceAll(',', '').split('.').first;
    double currentAmount = double.tryParse(currentText) ?? 0.0;
    double newAmount = currentAmount + value;
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final bool isAmountValid = _isAmountSufficient() && !_amountInvalid;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 32.w,
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
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: textColor,
            ),
          ),
        ),
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
                                color: amountController.text == "0.00"
                                    ? const Color(0xffC9CACC)
                                    : _amountInvalid
                                        ? Colors.red
                                        : textColor,
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
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmountButton('+₹5,000', isDark, () => _addAmount(5000)),
              SizedBox(width: 16.w),
              _buildAmountButton('+₹10,000', isDark, () => _addAmount(10000)),
              SizedBox(width: 16.w),
              _buildAmountButton('+₹20,000', isDark, () => _addAmount(20000)),
            ],
          ),
          const Spacer(),
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
          _buildNumberKeypad(isDark),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    isAmountValid
                        ? const Color(0xFF00C853)
                        : const Color(0xff2f2f2f),
                  ),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
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
                    : null,
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

  Widget _buildNumberKeypad(bool isDark) {
    final textColor = const Color(0xFF1DB954);

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
                  color: const Color(0xFF00C853),
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
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _handleKeypadPress(String input) {
    String currentText =
        amountController.text.replaceAll(',', '').split('.').first;

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
    } else {
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

  void _handleBackspace() {
    String currentText = amountController.text.replaceAll(',', '');
    String integerPart = currentText.split('.').first;

    if (_isDecimalMode) {
      setState(() {
        _isDecimalMode = false;
        _decimalPart = '';
        amountText =
            '${NumberUtils.formatIndianNumber(integerPart.isEmpty ? '0' : integerPart)}.00';
        amountController.text = amountText;
      });
    } else {
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

  void _selectPaymentMethod(BuildContext context, bool isDark, String amount) {
    double parsedAmount = double.tryParse(amount.replaceAll(',', '')) ?? 0.0;
    bool isAboveTwoLakh = parsedAmount > 200000;

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
                    color: isDark ? const Color(0xffC9CACC) : const Color(0xff6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
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
              constWidgets.greenButton(
                "Add ${amountController.text}",
                onTap: () {},
              ),
              SizedBox(height: 15.h),
            ],
          ),
        );
      },
    );
  }
}
