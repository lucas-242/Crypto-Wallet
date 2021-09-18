import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static final logo = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final title = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final titleBold = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final cryptoTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final cryptoTitleBold = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final buttonPrimary = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
  static final buttonGrey = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final input = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.input,
  );
  static final body = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final bodyBold = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final bodyWhite = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final bodyBoldWhite = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
}
