import 'package:bloc_ecomm/screens/others/splash_screen.dart';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegan Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.screenBackground,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.activatedButtonContainer,
          onPrimary: Colors.white,
          secondary: AppColors.outlinedButtonText,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: AppColors.screenBackground,
          onBackground: AppColors.bodyTextFont,
          surface: AppColors.fieldsBackground,
          onSurface: AppColors.bodyTextFont,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.screenBackground,
          foregroundColor: AppColors.mainHeading,
          titleTextStyle: AppTextStyles.mainHeading,
          elevation: 0,
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.mainHeading,
          headlineMedium: AppTextStyles.headingRegular,
          headlineSmall: AppTextStyles.headingMedium,
          titleMedium: AppTextStyles.buttonText,
          bodyLarge: AppTextStyles.bodyText14,
          bodyMedium: AppTextStyles.bodyText14,
          bodySmall: AppTextStyles.bodyText12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.fieldsBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.fieldsUnselectedStroke),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.fieldsSelectedStroke),
          ),
          labelStyle: TextStyle(color: AppColors.unselectedFieldsFont),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.activatedButtonContainer,
            foregroundColor: Colors.white,
            textStyle: AppTextStyles.buttonText,
            disabledBackgroundColor: AppColors.disabledButtonContainer,
            disabledForegroundColor: AppColors.disabledButtonText,
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.outlinedButtonText,
            side: BorderSide(color: AppColors.outlinedButtonStroke, width: 2),
            textStyle: AppTextStyles.buttonText,
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.snackBarContainer,
          contentTextStyle: AppTextStyles.bodyText14,
          behavior: SnackBarBehavior.floating,
          elevation: 4,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
