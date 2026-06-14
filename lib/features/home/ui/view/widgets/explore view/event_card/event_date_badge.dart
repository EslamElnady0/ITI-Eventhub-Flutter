import 'package:flutter/material.dart';

import '../../../../../../../core/assets/app_strings.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';

class EventDateBadge extends StatelessWidget {
  const EventDateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.eventDay,
            style: AppTextStyles.font18SemiBold.withColor(
              AppColors.sportsCategory,
            ),
          ),
          Text(
            AppStrings.eventMonth,
            style: AppTextStyles.font12Medium.withColor(
              AppColors.sportsCategory,
            ),
          ),
        ],
      ),
    );
  }
}
