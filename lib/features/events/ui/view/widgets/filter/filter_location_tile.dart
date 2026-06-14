import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class FilterLocationTile extends StatelessWidget {
  const FilterLocationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.location, style: AppTextStyles.font14Medium),
        vGap(10),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColorShade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
              hGap(10),
              Expanded(
                child: Text(
                  AppStrings.newYorkUSA,
                  style: AppTextStyles.font14Regular,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.primaryColor),
            ],
          ),
        ),
      ],
    );
  }
}
