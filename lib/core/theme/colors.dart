import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF5669FF);
  static const Color blue = Color(0xFF3D56F0);
  static const Color primaryColorShade50 = Color(0xFFF3F5FF);
  static const Color primaryColorShade100 = Color(0xFFE8EDFF);
  static const Color primaryColorShade200 = Color(0xFFD1DBFF);
  static const Color primaryColorShade300 = Color(0xFFBACAFF);
  static const Color primaryColorShade400 = Color(0xFFA3B8FF);
  static const Color primaryColorShade500 = Color(0xFF8CA7FF);
  static const Color primaryColorShade600 = Color(0xFF7595FF);
  static const Color primaryColorShade700 = Color(0xFF5E84FF);
  static const Color primaryColorShade800 = Color(0xFF4773FF);
  static const Color primaryColorShade900 = Color(0xFF3061FF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF120D26);
  static const Color gray = Color(0xFFE4DFDF);
  static const Color darkGray = Color(0xFF747688);
  static const Color sportsCategory = Color(0xFFFF6B6B);
  static const Color musicCategory = Color(0xFFF6A15A);
  static const Color foodCategory = Color(0xFF29D697);
}

extension AppColorsExtension on Color {
  MaterialColor get materialPrimaryColor =>
      MaterialColor(AppColors.primaryColor.toARGB32(), {
        50: AppColors.primaryColorShade50,
        100: AppColors.primaryColorShade100,
        200: AppColors.primaryColorShade200,
        300: AppColors.primaryColorShade300,
        400: AppColors.primaryColorShade400,
        500: AppColors.primaryColorShade500,
        600: AppColors.primaryColorShade600,
        700: AppColors.primaryColorShade700,
        800: AppColors.primaryColorShade800,
        900: AppColors.primaryColorShade900,
      });
}
