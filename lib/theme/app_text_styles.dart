import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle mainHeading = GoogleFonts.outfit(
    fontWeight: FontWeight.w600, // semibold
    fontSize: 24,
    color: AppColors.mainHeading,
  );

  static final TextStyle headingRegular = GoogleFonts.outfit(
    fontWeight: FontWeight.w400, // regular
    fontSize: 20,
    color: AppColors.mainHeading,
  );

  static final TextStyle headingMedium = GoogleFonts.outfit(
    fontWeight: FontWeight.w500, // medium
    fontSize: 16,
    color: AppColors.mainHeading,
  );

  static final TextStyle buttonText = GoogleFonts.inter(
    fontWeight: FontWeight.w400, // regular
    fontSize: 16,
    color: AppColors.activatedButtonText,
  );

  static final TextStyle bodyText14 = GoogleFonts.outfit(
    fontWeight: FontWeight.w400, // regular
    fontSize: 14,
    color: AppColors.bodyTextFont,
  );

  static final TextStyle bodyText12 = GoogleFonts.outfit(
    fontWeight: FontWeight.w400, // regular
    fontSize: 12,
    color: AppColors.bodyTextFont,
  );
}
