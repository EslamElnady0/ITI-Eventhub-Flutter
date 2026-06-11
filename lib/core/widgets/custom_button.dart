import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';
import '../theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 18;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          children: [
            const SizedBox(width: avatarRadius * 2),
            Expanded(
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyles.font16Medium.withColor(AppColors.white),
              ),
            ),
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: AppColors.blue,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
