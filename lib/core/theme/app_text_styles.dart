import 'package:flutter/widgets.dart';

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle font24Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font22SemiBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16Medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font14Medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font18Regular = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font20Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.regular,
  );
}

extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}

class FontWeightHelper {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
