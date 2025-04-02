import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    // Define the base text theme
    final TextTheme baseTextTheme = TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 57,
        height: 64/57,
        letterSpacing: -0.25,
        color: AppColors.text,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 45,
        height: 52/45,
        letterSpacing: 0,
        color: AppColors.text,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 36,
        height: 44/36,
        letterSpacing: 0,
        color: AppColors.text,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 32,
        height: 40/32,
        letterSpacing: 0,
        color: AppColors.text,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 28,
        height: 36/28,
        letterSpacing: 0,
        color: AppColors.text,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        height: 32/24,
        letterSpacing: 0,
        color: AppColors.text,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 22,
        height: 28/22,
        letterSpacing: 0,
        color: AppColors.text,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        height: 24/18,
        letterSpacing: 0.15,
        color: AppColors.text,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 20/14,
        letterSpacing: 0.1,
        color: AppColors.text,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24/16,
        letterSpacing: 0.5,
        color: AppColors.text,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20/14,
        letterSpacing: 0.25,
        color: AppColors.text,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 16/12,
        letterSpacing: 0.4,
        color: AppColors.lightText,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 20/14,
        letterSpacing: 0.1,
        color: AppColors.text,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 16/12,
        letterSpacing: 0.5,
        color: AppColors.text,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 16/11,
        letterSpacing: 0.5,
        color: AppColors.text,
      ),
    );

    return ThemeData(
      textTheme: baseTextTheme,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.primary,
        onSecondary: Colors.white,
        surface: AppColors.background,
        error: AppColors.error,
      ),

      // Primary color for AppBar, FloatingActionButton, etc.
      primaryColor: AppColors.primary,

      // Scaffolds and backgrounds
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.card,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: baseTextTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 1.0,
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // FloatingActionButton theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),


      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.background,
        filled: true,
        hintStyle: baseTextTheme.bodyLarge?.copyWith(
          color: AppColors.lightText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 32,
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }
}


class AppTextStyles {
  // This method allows us to get the text styles from the current theme
  static TextTheme _getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  // Input text styles
  static TextStyle inputHint(BuildContext context) {
    return _getTextTheme(context).bodyLarge!.copyWith(
      color: AppColors.lightText,
      fontSize: 16,
      height: 20/16,
      letterSpacing: 0,
    );
  }

  static TextStyle input(BuildContext context) {
    return _getTextTheme(context).bodyLarge!.copyWith(
      color: AppColors.inoutText,
      fontSize: 16,
      height: 20/16,
      letterSpacing: 0,
    );
  }

  // Button text styles
  static TextStyle negativeButtonText(BuildContext context) {
    return _getTextTheme(context).labelLarge!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.0,
      letterSpacing: 0,
    );
  }

  static TextStyle positiveButtonText(BuildContext context) {
    return _getTextTheme(context).labelLarge!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.0,
      letterSpacing: 0,
    );
  }

  // Bottom sheet text style
  static TextStyle bottomSheetText(BuildContext context) {
    return _getTextTheme(context).bodyLarge!.copyWith(
      fontSize: 16,
      height: 20/16,
      letterSpacing: 0,
    );
  }

  // App bar title text style
  static TextStyle appBarTitle(BuildContext context) {
    return _getTextTheme(context).titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.0,
      letterSpacing: 0,
      color: Colors.white,
    );
  }

  // Divider title heading
  static TextStyle dividerTitle(BuildContext context) {
    return _getTextTheme(context).titleSmall!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24/16,
      letterSpacing: 0,
    );
  }

  // Card text styles
  static TextStyle cardEmployeeName(BuildContext context) {
    return _getTextTheme(context).titleSmall!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 20/16,
      letterSpacing: 0,
      color: AppColors.text,
    );
  }

  static TextStyle cardSubtitle(BuildContext context) {
    return _getTextTheme(context).bodyMedium!.copyWith(
      fontSize: 14,
      height: 20/14,
      letterSpacing: 0,
      color: AppColors.lightText,
    );
  }

  static TextStyle cardDateTime(BuildContext context) {
    return _getTextTheme(context).bodySmall!.copyWith(
      fontSize: 12,
      height: 20/12,
      letterSpacing: 0,
      color: AppColors.lightText,
    );
  }

  // Swipe delete message
  static TextStyle swipeDeleteMessage(BuildContext context) {
    return _getTextTheme(context).bodyMedium!.copyWith(
      fontSize: 15,
      height: 20/15,
      letterSpacing: 0,
      color: AppColors.lightText,
      fontStyle: FontStyle.italic,
    );
  }
}