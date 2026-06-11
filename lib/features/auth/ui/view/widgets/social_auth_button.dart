import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class SocialAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String assetPath;
  const SocialAuthButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(assetPath, width: 24, height: 24),
            hGap(16),
            Text(
              label,
              style: AppTextStyles.font16Medium.withColor(AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
