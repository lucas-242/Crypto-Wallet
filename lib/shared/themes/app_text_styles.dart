import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static final logo = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final title = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final titleBold = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final cryptoTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final cryptoTitleBold = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final buttonPrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
  static final buttonGrey = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final input = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.input,
  );
  static final body = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final bodyBold = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final bodyWhite = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static final bodyBoldWhite = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
