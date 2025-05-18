// File: main.dart
// Description: Entry point for the Sapphire Trading application.
// This file configures theming, navigation utilities, and launches the app.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/account/profile/profile.dart';
import 'package:sapphire/screens/auth/signUp/aadharDetails/aadharDetails.dart';
import 'package:sapphire/screens/auth/signUp/congratulations.dart';
import 'package:sapphire/screens/auth/signUp/finalStep/eSign.dart';
import 'package:sapphire/screens/auth/signUp/initialPage.dart';
import 'package:sapphire/screens/auth/signUp/signature/signature.dart';
import 'package:sapphire/screens/home/homeWarpper.dart';
import 'package:sapphire/themeProvider.dart'; // Theme state management
import 'package:provider/provider.dart'; // State management solution
import 'package:sapphire/utils/appTheme.dart'; // App-wide theme configurations.

/// Application entry point
/// Initializes Flutter binding and sets up the theme provider
void main() {
  // Ensure Flutter is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Wrap the app with Provider for theme state management
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

/// Global navigator key
/// Allows navigation actions from anywhere in the app without BuildContext
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Navigate to a new screen with a slide transition
///
/// Parameters:
/// - nextScreen: The widget to navigate to
/// - context: Current BuildContext for navigation
void navi(Widget nextScreen, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        // Configure the animation with tween and curve
        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Apply slide transition animation
        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

/// Navigate and replace current screen with a slide transition
/// Used for screen replacements where returning to previous screen isn't desired
///
/// Parameters:
/// - nextScreen: The widget to navigate to
/// - context: Current BuildContext for navigation
void naviRep(Widget nextScreen, BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        // Configure the animation with tween and curve
        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Apply slide transition animation
        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

/// Main application widget
/// Configures theme settings, responsive layout, and initial route
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current theme mode from provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Initialize ScreenUtil for responsive UI scaling
    return ScreenUtilInit(
      designSize:
          const Size(393, 852), // Base design size for responsive calculations
      minTextAdapt: true, // Adapt text size based on screen size
      splitScreenMode: true, // Support split screen mode
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey, // Set global navigator key
          debugShowCheckedModeBanner: false, // Remove debug banner
          theme: AppThemes.lightTheme, // Light theme configuration
          darkTheme: AppThemes.darkTheme, // Dark theme configuration
          themeMode:
              themeProvider.themeMode, // Current theme mode (system/light/dark)
          home: HomeWrapper(), // Starting screen of the application
          // home: loginOtp(), // Alternate entry point (currently commented out)
        );
      },
    );
  }
}
