import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AboutEventSection extends StatelessWidget {
  const AboutEventSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.aboutEvent, style: AppTextStyles.font20Bold),
        vGap(8),
        Text(description, style: AppTextStyles.font16Regular),
      ],
    );
  }
}
