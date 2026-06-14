import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../models/filter_category_model.dart';

class FilterCategoriesList extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterCategoriesList({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<FilterCategoryModel> categories = [
    FilterCategoryModel(
      title: AppStrings.sports,
      icon: Icons.sports_basketball,
    ),
    FilterCategoryModel(title: AppStrings.music, icon: Icons.music_note),
    FilterCategoryModel(title: AppStrings.art, icon: Icons.palette_outlined),
    FilterCategoryModel(title: AppStrings.food, icon: Icons.restaurant),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => hGap(12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = index == selectedIndex;

          return InkWell(
            onTap: () => onSelected(index),
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: 52,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? AppColors.primaryColor
                          : AppColors.white,
                      border: Border.all(
                        color: selected
                            ? AppColors.primaryColor
                            : AppColors.gray,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      category.icon,
                      color: selected ? AppColors.white : AppColors.darkGray,
                    ),
                  ),
                  vGap(6),
                  Text(
                    category.title,
                    style: AppTextStyles.font12Medium.withColor(
                      AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
