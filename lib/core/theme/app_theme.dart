import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: const TextTheme(
        bodySmall: AppTextStyle.bodyXS,
        bodyMedium: AppTextStyle.bodyS,
        bodyLarge: AppTextStyle.bodyM,
        titleLarge: AppTextStyle.productTitle,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: AppTextStyle.productTitle,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          textStyle: AppTextStyle.buttonText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      dividerColor: AppColors.greyLight,
    );
  }
}
