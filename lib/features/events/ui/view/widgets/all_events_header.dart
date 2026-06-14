import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class AllEventsHeader extends StatelessWidget implements PreferredSizeWidget {
  const AllEventsHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      title: Text(
        AppStrings.events,
        style: AppTextStyles.font24Bold.withColor(AppColors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: AppColors.black),
        ),
      ],
    );
  }
}
