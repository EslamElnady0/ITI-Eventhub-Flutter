import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthFooter({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: AppTextStyles.font15Medium.withColor(AppColors.black),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          onPressed: onPressed,
          child: Text(
            AppStrings.signUp,
            style: AppTextStyles.font15Medium.withColor(AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
