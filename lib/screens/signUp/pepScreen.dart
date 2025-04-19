import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/linkBankScreen.dart';

import '../../utils/constWidgets.dart';

class pepScreen extends StatefulWidget {
  const pepScreen({super.key});

  @override
  State<pepScreen> createState() => _pepScreenState();
}

class _pepScreenState extends State<pepScreen> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    width = MediaQuery.of(context).size.width / 2 - 20;
    print(width);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constWidgets.topProgressBar(1, 6, context),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Few more details",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Are you a Politically Exposed Person (PEP)?",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                constWidgets.choiceChip("Yes", false, context, 82.w, isDark),
                SizedBox(
                  width: 20.w,
                ),
                constWidgets.choiceChip("No", true, context, 82.w, isDark),
              ],
            ),

            Expanded(child: SizedBox()),

            constWidgets.greenButton("Continue", onTap: () {
              navi(linkBankScreen(), context);
            }),
            SizedBox(height: 10.h),

            /// Need Help Button
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
