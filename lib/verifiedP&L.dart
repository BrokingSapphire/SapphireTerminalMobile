import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifiedPnL extends StatefulWidget {
  const VerifiedPnL({super.key});

  @override
  State<VerifiedPnL> createState() => _VerifiedPnLState();
}

class _VerifiedPnLState extends State<VerifiedPnL> {
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
          "Verified P&L",
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
            color: Color(0xFF2F2F2F),
          )
        ],
      ),
    );
  }
}
