import 'package:flutter/material.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';

class ExploreView extends StatelessWidget {
  static const String routeName = '/explore';

  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.explore,
        style: AppTextStyles.font24Bold.withColor(AppColors.black),
      ),
    );
  }
}
