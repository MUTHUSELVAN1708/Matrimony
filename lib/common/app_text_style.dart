import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';

class AppTextStyles {
  static const fontName = 'Helvetica';
  static const TextStyle heading = TextStyle(
    fontFamily: fontName,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    height: 1.15,
    color: AppColors.primaryButtonTextColor,
  );

  static const TextStyle spanTextStyle = TextStyle(
    fontFamily: fontName,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 16.1 / 14,
    color: AppColors.spanTextColor,
  );

  static const TextStyle secondrySpanTextStyle = TextStyle(
    fontFamily: fontName,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    height: 16.1 / 14,
    color: AppColors.secondryspanTextColor,
  );

  static const TextStyle headingTextstyle = TextStyle(
    fontFamily: fontName,
    fontSize: 21,
    fontWeight: FontWeight.w700,
    height: 21.85 / 19,
    color: AppColors.headingTextColor,
  );

  static const TextStyle primarybuttonText = TextStyle(
    fontFamily: fontName,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryButtonTextColor,
    letterSpacing: 1.25,
  );

  static const TextStyle secondaryButton = TextStyle(
      fontFamily: fontName,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.15,
      color: AppColors.secondaryButtonColor);
  static ButtonStyle primaryButtonstyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryButtonColor,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static ButtonStyle secondaryButtonstyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    side: const BorderSide(color: Colors.black, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
