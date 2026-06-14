import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const AuthFooter({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyles.font15Medium.withColor(AppColors.black),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const .symmetric(horizontal: 8, vertical: 4),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppTextStyles.font15Medium.withColor(AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
