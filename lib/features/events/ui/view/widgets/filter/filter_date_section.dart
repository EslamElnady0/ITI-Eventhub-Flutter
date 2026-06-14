import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class FilterDateSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterDateSection({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<String> dateOptions = [
    AppStrings.today,
    AppStrings.tomorrow,
    AppStrings.thisWeek,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.timeAndDate, style: AppTextStyles.font14Medium),
        vGap(12),
        Wrap(
          spacing: 8,
          children: [
            for (var index = 0; index < dateOptions.length; index++)
              ChoiceChip(
                label: Text(dateOptions[index]),
                selected: selectedIndex == index,
                onSelected: (_) => onSelected(index),
                showCheckmark: false,
                selectedColor: AppColors.primaryColor,
                backgroundColor: AppColors.white,
                side: BorderSide(
                  color: selectedIndex == index
                      ? AppColors.primaryColor
                      : AppColors.gray,
                ),
                labelStyle: AppTextStyles.font12Medium.withColor(
                  selectedIndex == index ? AppColors.white : AppColors.darkGray,
                ),
              ),
          ],
        ),
        vGap(8),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.primaryColor,
            size: 18,
          ),
          label: const Text(AppStrings.chooseFromCalendar),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkGray,
            side: const BorderSide(color: AppColors.gray),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
