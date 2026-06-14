import 'package:flutter/material.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.profile,
        style: AppTextStyles.font24Bold.withColor(AppColors.black),
      ),
    );
  }
}
