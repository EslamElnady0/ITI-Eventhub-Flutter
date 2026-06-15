import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';

class EventDateBadge extends StatelessWidget {
  const EventDateBadge({super.key, required this.day, required this.month});

  final String day;
  final String month;

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
            day,
            style: AppTextStyles.font18SemiBold.withColor(
              AppColors.sportsCategory,
            ),
          ),
          Text(
            month,
            style: AppTextStyles.font12Medium.withColor(
              AppColors.sportsCategory,
            ),
          ),
        ],
      ),
    );
  }
}
