import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/assets/assets.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class SearchBarWidget extends StatelessWidget {
  final Color foregroundColor;
  final Color? hintColor;
  final Color? dividerColor;
  final Color? filterBackgroundColor;
  final Color? filterForegroundColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    super.key,
    this.foregroundColor = AppColors.white,
    this.hintColor,
    this.dividerColor,
    this.filterBackgroundColor,
    this.filterForegroundColor,
    this.readOnly = false,
    this.onTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.assetsImagesSearchIcon,
          height: 26,
          width: 26,
          colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
        ),
        hGap(8),
        Container(
          width: 2,
          height: 26,
          color: dividerColor ?? foregroundColor.withValues(alpha: 0.3),
        ),
        hGap(12),
        Expanded(
          child: TextField(
            readOnly: readOnly,
            onTap: onTap,
            style: AppTextStyles.font16Regular.withColor(foregroundColor),
            decoration: InputDecoration(
              hintText: AppStrings.search,
              hintStyle: AppTextStyles.font16Regular.withColor(
                hintColor ?? foregroundColor.withValues(alpha: 0.7),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        hGap(12),
        Material(
          color:
              filterBackgroundColor ?? foregroundColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(50),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.assetsImagesFilterCircleIcon,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      filterForegroundColor ?? foregroundColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  hGap(4),
                  Text(
                    AppStrings.filters,
                    style: AppTextStyles.font12Medium.withColor(
                      filterForegroundColor ?? foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
