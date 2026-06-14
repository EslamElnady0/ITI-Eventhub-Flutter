import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.darkGray,
      labelStyle: AppTextStyles.font14Medium,
      unselectedLabelStyle: AppTextStyles.font14Medium,
      indicatorColor: AppColors.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabs: [
        Tab(text: AppStrings.about.toUpperCase()),
        Tab(text: AppStrings.favs.toUpperCase()),
      ],
    );
  }
}
