import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/helpers/spacing.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AboutEventSection extends StatelessWidget {
  const AboutEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.aboutEvent, style: AppTextStyles.font20Bold),
        vGap(8),
        Text(
          AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription +
              AppStrings.eventDescription,
          style: AppTextStyles.font16Regular,
        ),
      ],
    );
  }
}
