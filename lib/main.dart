import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/accountSection/accountScreen.dart';
import 'package:sapphire/screens/accountSection/fundsScreen.dart';
import 'package:sapphire/screens/accountSection/ledgerScreen.dart';
import 'package:sapphire/screens/accountSection/profileScreen.dart';
import 'package:sapphire/screens/accountSection/profitAndLoss.dart';
import 'package:sapphire/screens/accountSection/sessionManagement.dart';
import 'package:sapphire/screens/accountSection/settingsOrderPreference.dart';
import 'package:sapphire/screens/accountSection/tradesAndCharges.dart';
import 'package:sapphire/screens/home/homeWarpper.dart';
import 'package:sapphire/screens/home/orders/Gtt1Screen.dart';
import 'package:sapphire/screens/home/orders/Gtt2Screen.dart';
import 'package:sapphire/screens/home/orders/alertScreen.dart';
import 'package:sapphire/screens/home/orders/basketScreen.dart';
import 'package:sapphire/screens/home/orders/createGttScreen.dart';
import 'package:sapphire/screens/home/searchPage.dart';
import 'package:sapphire/screens/home/watchlist/disclosure.dart';
import 'package:sapphire/screens/orderWindow/BuyScreens/buyScreenWrapper.dart';
import 'package:sapphire/screens/orderWindow/SellScreens/sellScreenWrapper.dart';
import 'package:sapphire/screens/signUp/ConfirmBankDetails.dart';
import 'package:sapphire/screens/signUp/ManualLinkingScreen.dart';
import 'package:sapphire/screens/signUp/NomineeScreen.dart';
import 'package:sapphire/screens/signUp/SelfieCameraScreen.dart';
import 'package:sapphire/screens/signUp/SignCanvaScreen.dart';
import 'package:sapphire/screens/signUp/congratulationsScreen.dart';
// import 'package:sapphire/screens/signUp/desktopAuthScreen.dart';
import 'package:sapphire/screens/signUp/eSignScreen.dart';
import 'package:sapphire/screens/signUp/emailScreen.dart';
import 'package:sapphire/screens/signUp/familyDetailsScreen.dart';
import 'package:sapphire/screens/signUp/initialScreen.dart';
import 'package:sapphire/screens/signUp/ipvScreen.dart';
import 'package:sapphire/screens/signUp/linkBankScreen.dart';
import 'package:sapphire/screens/signUp/linkWithUpiScreen.dart';
import 'package:sapphire/screens/signUp/loginScreen.dart';
import 'package:sapphire/screens/signUp/mPinScreen.dart';
import 'package:sapphire/screens/signUp/mobileOtp.dart';
import 'package:sapphire/screens/signUp/mobileOtpVerification.dart';
import 'package:sapphire/screens/signUp/nomineeDetailsScreen.dart';
import 'package:sapphire/screens/signUp/panDetails.dart';
import 'package:sapphire/screens/signUp/personalDetails.dart';
import 'package:sapphire/screens/signUp/rasScreen.dart';
import 'package:sapphire/screens/signUp/segmentSelectionScreen.dart';
import 'package:sapphire/screens/signUp/signUpPaymentScreen.dart';
import 'package:sapphire/screens/signUp/signatureVerificationScreen.dart';
import 'package:sapphire/screens/signUp/tradingExperienceScreen.dart';
import 'package:sapphire/screens/signUp/verifyAadharScreen.dart';
import 'package:sapphire/screens/signUp/yourInvestmentProfile.dart';
import 'package:sapphire/utils/appTheme.dart';
import 'package:sapphire/utils/watchlistTabBar.dart';
import 'package:sapphire/verifiedP&L.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey, // Set navigator key here

          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          // home: InitialScreen()
          // home: MobileOtp(
          //   email: "",
          // ));
          // home: SellScreenWrapper());
          // home: InitialScreen(),
          home: VerifiedPnL(),
        );
      },
    );
  }
}
