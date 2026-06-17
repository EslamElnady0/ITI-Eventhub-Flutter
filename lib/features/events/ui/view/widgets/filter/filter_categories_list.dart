import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../home/data/entities/home_category_entity.dart';

class FilterCategoriesList extends StatelessWidget {
  final int selectedIndex;
  final List<HomeCategoryEntity> categories;
  final ValueChanged<int> onSelected;

  const FilterCategoriesList({
    super.key,
    required this.selectedIndex,
    required this.categories,
    required this.onSelected,
  });

  static const List<HomeCategoryEntity> fallbackCategories = [
    HomeCategoryEntity(
      id: 'sports',
      name: AppStrings.sports,
      apiName: 'sports',
    ),
    HomeCategoryEntity(id: 'music', name: AppStrings.music, apiName: 'music'),
    HomeCategoryEntity(
      id: 'arts',
      name: AppStrings.art,
      apiName: 'Arts & Theatre',
    ),
    HomeCategoryEntity(
      id: 'food',
      name: AppStrings.food,
      apiName: 'Food & Drink',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categoryOptions = categories.isEmpty
        ? fallbackCategories
        : categories;

    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoryOptions.length,
        separatorBuilder: (context, index) => hGap(12),
        itemBuilder: (context, index) {
          final category = categoryOptions[index];
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
                      _iconFor(category.name),
                      color: selected ? AppColors.white : AppColors.darkGray,
                    ),
                  ),
                  vGap(6),
                  Text(
                    category.name,
                    style: AppTextStyles.font12Medium.withColor(
                      AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _iconFor(String name) {
    switch (name) {
      case AppStrings.sports:
        return Icons.sports_basketball;
      case AppStrings.music:
        return Icons.music_note;
      case AppStrings.food:
      case 'Food & Drink':
      case 'Miscellaneous':
        return Icons.restaurant;
      case AppStrings.art:
      case 'Arts & Theatre':
      case 'Film':
        return Icons.palette_outlined;
      default:
        return Icons.event;
    }
  }
}
