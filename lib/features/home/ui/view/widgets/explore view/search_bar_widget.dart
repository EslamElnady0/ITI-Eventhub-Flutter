import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/assets/assets.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.assetsImagesSearchIcon, height: 26, width: 26),
        hGap(8),
        Container(
          width: 2,
          height: 26,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        hGap(12),
        Expanded(
          child: TextField(
            style: AppTextStyles.font16Regular.withColor(AppColors.white),
            decoration: InputDecoration(
              hintText: AppStrings.search,
              hintStyle: AppTextStyles.font16Regular.withColor(
                AppColors.white.withValues(alpha: 0.7),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        hGap(12),
        Container(
          padding: const .all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: .circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.assetsImagesFilterCircleIcon,
                height: 20,
                width: 20,
              ),
              hGap(4),
              Text(
                AppStrings.filters,
                style: AppTextStyles.font12Medium.withColor(AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
