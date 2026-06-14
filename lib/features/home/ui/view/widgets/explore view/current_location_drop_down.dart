import 'package:flutter/material.dart';
import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class CurrentLocationDropDown extends StatelessWidget {
  const CurrentLocationDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: AppStrings.currentLocation,
      position: PopupMenuPosition.under,
      onSelected: (_) {},
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AppStrings.newYorkUSA,
          child: Text(AppStrings.newYorkUSA),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.currentLocation,
                style: AppTextStyles.font12Medium.withColor(
                  AppColors.white.withValues(alpha: 0.7),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColors.white,
                size: 24,
              ),
            ],
          ),
          Text(
            AppStrings.newYorkUSA,
            style: AppTextStyles.font14Regular
                .withColor(AppColors.white)
                .withFontWeight(FontWeightHelper.bold),
          ),
        ],
      ),
    );
  }
}
