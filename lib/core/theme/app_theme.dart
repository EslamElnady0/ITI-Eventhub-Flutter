import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    primarySwatch: AppColors.primaryColor.materialPrimaryColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.primaryColor.materialPrimaryColor,
      accentColor: AppColors.primaryColor,
    ).copyWith(secondary: AppColors.primaryColor),
    scaffoldBackgroundColor: Colors.white,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return AppColors.darkGray;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
