import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class FilterPriceRangeSection extends StatelessWidget {
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  const FilterPriceRangeSection({
    super.key,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.selectPriceRange,
              style: AppTextStyles.font14Medium,
            ),
            Text(
              '\$${values.start.round()}-\$${values.end.round()}',
              style: AppTextStyles.font14Medium.withColor(
                AppColors.primaryColor,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: 0,
          max: 150,
          divisions: 15,
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.primaryColorShade200,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
