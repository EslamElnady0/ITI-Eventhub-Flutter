import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class EventsListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback onSearch;
  final VoidCallback onMore;

  const EventsListAppBar({
    super.key,
    required this.onBack,
    required this.onSearch,
    required this.onMore,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
      ),
      title: Text(
        AppStrings.events,
        style: AppTextStyles.font20SemiBold.withColor(AppColors.black),
      ),
      actions: [
        IconButton(
          tooltip: AppStrings.searchTitle,
          onPressed: onSearch,
          icon: const Icon(Icons.search, color: AppColors.black),
        ),
        IconButton(
          tooltip: AppStrings.moreOptions,
          onPressed: onMore,
          icon: const Icon(Icons.more_vert, color: AppColors.black),
        ),
      ],
    );
  }
}
