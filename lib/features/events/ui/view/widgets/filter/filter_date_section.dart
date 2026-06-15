import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class FilterDateSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final ValueChanged<DateTime> onCustomDateSelected;
  final DateTime? customDate;

  const FilterDateSection({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.onCustomDateSelected,
    required this.customDate,
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
          onPressed: () async {
            final now = DateTime.now();
            final date = await showDatePicker(
              context: context,
              initialDate: customDate ?? now,
              firstDate: now,
              lastDate: DateTime(now.year + 2),
            );
            if (date != null) onCustomDateSelected(date);
          },
          icon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.primaryColor,
            size: 18,
          ),
          label: Text(
            customDate == null
                ? AppStrings.chooseFromCalendar
                : '${customDate!.day}/${customDate!.month}/${customDate!.year}',
          ),
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
