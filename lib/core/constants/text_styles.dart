import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const TextStyle bodyXS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 13 / 11,
    color: AppColors.black,
  );

  static const TextStyle bodyS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 16 / 13,
    color: AppColors.black,
  );

  static const TextStyle bodyM = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 19 / 16,
    color: AppColors.black,
  );

  static const TextStyle productTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 24 / 20,
    color: AppColors.black,
  );

  static const TextStyle price = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 26 / 22,
    color: AppColors.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    color: AppColors.white,
  );
}
