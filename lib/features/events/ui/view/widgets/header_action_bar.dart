import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/theme/app_text_styles.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/colors.dart';

class HeaderActionBar extends StatelessWidget {
  const HeaderActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          BackButton(color: AppColors.white),
          Text(
            AppStrings.eventDetails,
            style: AppTextStyles.font24Bold.copyWith(color: AppColors.white),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsetsDirectional.only(end: 16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.bookmark, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
