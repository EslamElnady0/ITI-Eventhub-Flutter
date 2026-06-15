import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/assets/assets.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../data/entities/home_category_entity.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final HomeCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    final presentation = _presentationFor(category.name);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: presentation.$2,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            presentation.$1,
            colorFilter: ColorFilter.mode(AppColors.white, .srcIn),
            width: 18,
            height: 18,
          ),
          hGap(8),
          Text(
            category.name,
            style: AppTextStyles.font16Regular.withColor(AppColors.white),
          ),
        ],
      ),
    );
  }

  (String, Color) _presentationFor(String name) {
    switch (name) {
      case AppStrings.music:
        return (Assets.assetsImagesMusicIcon, AppColors.musicCategory);
      case 'Miscellaneous':
        return (Assets.assetsImagesFoodIcon, AppColors.foodCategory);
      case 'Arts & Theatre':
      case 'Film':
        return (Assets.assetsImagesCompass, AppColors.primaryColor);
      case AppStrings.sports:
        return (Assets.assetsImagesBallIcon, AppColors.sportsCategory);
      case 'Default':
        return (Assets.assetsImagesDefaultCategoryIcon, AppColors.darkGray);
      case AppStrings.food:
        return (Assets.assetsImagesFoodIcon, AppColors.foodCategory);
      default:
        return (Assets.assetsImagesDefaultCategoryIcon, AppColors.primaryColor);
    }
  }
}
