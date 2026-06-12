import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class EmptyEventsState extends StatelessWidget {
  const EmptyEventsState({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.assetsImagesCalender,
            width: MediaQuery.sizeOf(context).width * 0.48,
          ),
          vGap(24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font24Bold.withColor(AppColors.black),
          ),
          vGap(12),
          Text(
            AppStrings.loremIpsum,
            textAlign: TextAlign.center,
            style: AppTextStyles.font16Regular.withColor(AppColors.darkGray),
          ),
        ],
      ),
    );
  }
}
