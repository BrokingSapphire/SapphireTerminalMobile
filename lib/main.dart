import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/funds/withdrawal/withdrawal.dart';

import 'package:sapphire/screens/home/orders/gtt1Screen.dart';
import 'package:sapphire/screens/home/orders/gtt2Screen.dart';
import 'package:sapphire/screens/home/discover/priceAlerts.dart';
import 'package:sapphire/screens/home/orders/basketOrder.dart';
import 'package:sapphire/screens/home/orders/createGTT.dart';
import 'package:sapphire/screens/home/watchlist/searchPage.dart';
import 'package:sapphire/screens/home/riskDisclosure.dart';
import 'package:sapphire/screens/orderWindow/buyScreens/buyWrapper.dart';
import 'package:sapphire/screens/orderWindow/sellScreens/sellWrapper.dart';
import 'package:sapphire/screens/auth/signUp/bankDetails/confirmBankDetails.dart';
import 'package:sapphire/screens/auth/signUp/inPersonVerification/selfieConfirmation.dart';
import 'package:sapphire/screens/auth/signUp/bankDetails/linkManually.dart';
import 'package:sapphire/screens/auth/signUp/nomineeDetails/nominee.dart';
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/segmentSelection.dart';
import 'package:sapphire/screens/auth/signUp/inPersonVerification/selfieCamera.dart';
import 'package:sapphire/screens/auth/signUp/signature/signatureCanvas.dart';
import 'package:sapphire/screens/auth/signUp/congratulations.dart';
import 'package:sapphire/screens/auth/signUp/finalStep/eSign.dart';
import 'package:sapphire/screens/auth/signUp/contactDetails//email.dart';
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/familyDetails.dart';
import 'package:sapphire/screens/auth/signUp/initialPage.dart';
import 'package:sapphire/screens/auth/signUp/inPersonVerification/inPersonVerification.dart';
import 'package:sapphire/screens/auth/signUp/bankDetails/linkBankAccount.dart';
import 'package:sapphire/screens/auth/signUp/bankDetails/linkViaUPI.dart';
import 'package:sapphire/screens/auth/login/login.dart';
import 'package:sapphire/screens/auth/login/mPINScreen.dart';
import 'package:sapphire/screens/auth/signUp/contactDetails/mobile.dart';
import 'package:sapphire/screens/auth/signUp/contactDetails/mobileOTPVerification.dart';
import 'package:sapphire/screens/auth/signUp/nomineeDetails/nomineeDetails.dart';
import 'package:sapphire/screens/auth/signUp/panDetails/panDetails.dart';
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/personalDetails.dart';
import 'package:sapphire/screens/auth/signUp/signature/signature.dart';
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/otherDetails.dart';
import 'package:sapphire/screens/auth/signUp/aadharDetails/aadharDetails.dart';
import 'package:sapphire/utils/appTheme.dart';
import 'package:sapphire/themeProvider.dart';
import 'package:sapphire/wat.dart';
import 'package:signature/signature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void navi(Widget nextScreen, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

void naviRep(Widget nextScreen, BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeProvider.themeMode,
          home: InitialScreen(),
          // home: BuyScreenWrapper(),
        );
      },
    );
  }
}
