import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/assets/assets.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../models/category_model.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  static const List<CategoryModel> _categories = [
    CategoryModel(
      title: AppStrings.sports,
      icon: Assets.assetsImagesBallIcon,
      color: AppColors.sportsCategory,
    ),
    CategoryModel(
      title: AppStrings.music,
      icon: Assets.assetsImagesMusicIcon,
      color: AppColors.musicCategory,
    ),
    CategoryModel(
      title: AppStrings.food,
      icon: Assets.assetsImagesFoodIcon,
      color: AppColors.foodCategory,
    ),
    CategoryModel(
      title: AppStrings.sports,
      icon: Assets.assetsImagesBallIcon,
      color: AppColors.sportsCategory,
    ),
    CategoryModel(
      title: AppStrings.music,
      icon: Assets.assetsImagesMusicIcon,
      color: AppColors.musicCategory,
    ),
    CategoryModel(
      title: AppStrings.food,
      icon: Assets.assetsImagesFoodIcon,
      color: AppColors.foodCategory,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.048,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        separatorBuilder: (context, index) => hGap(10),
        itemBuilder: (context, index) {
          final category = _categories[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(category.icon, width: 18, height: 18),
                hGap(8),
                Text(
                  category.title,
                  style: AppTextStyles.font16Regular.withColor(AppColors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
