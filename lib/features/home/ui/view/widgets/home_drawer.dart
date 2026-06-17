import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onCalendarTap;
  final VoidCallback onSignOutTap;
  final String displayName;
  final String? displayEmail;

  const HomeDrawer({
    super.key,
    required this.onProfileTap,
    required this.onCalendarTap,
    required this.onSignOutTap,
    required this.displayName,
    this.displayEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 32, 12, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(Assets.assetsImagesManAvatar),
            ),
            vGap(12),
            Text(
              displayName,
              style: AppTextStyles.font18SemiBold.withColor(AppColors.black),
            ),
            if (displayEmail != null && displayEmail!.isNotEmpty) ...[
              vGap(4),
              Text(
                displayEmail!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font14Medium.withColor(AppColors.darkGray),
              ),
            ],
            vGap(28),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.person_outline,
                color: AppColors.darkGray,
              ),
              title: const Text(AppStrings.myProfile),
              onTap: onProfileTap,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.darkGray,
              ),
              title: const Text(AppStrings.events),
              onTap: onCalendarTap,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: AppColors.darkGray),
              title: const Text(AppStrings.signOut),
              onTap: onSignOutTap,
            ),
          ],
        ),
      ),
    );
  }
}
