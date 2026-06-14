import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class ProfileStatItem extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font16Medium.withColor(AppColors.black),
        ),
        Text(
          label,
          style: AppTextStyles.font12Medium.withColor(AppColors.darkGray),
        ),
      ],
    );
  }
}
