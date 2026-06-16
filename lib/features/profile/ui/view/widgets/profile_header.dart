import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';
import 'profile_stat_item.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.favoritesCount,
  });

  final String name;
  final String email;
  final int favoritesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundImage: AssetImage(Assets.assetsImagesOrgnizerPlaceholder),
        ),
        vGap(12),
        Text(
          name,
          style: AppTextStyles.font20SemiBold.withColor(AppColors.black),
        ),
        vGap(4),
        Text(
          email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font14Medium.withColor(AppColors.darkGray),
        ),
        vGap(14),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProfileStatItem(
                value: AppStrings.followingCount,
                label: AppStrings.following,
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 28),
                color: AppColors.gray,
              ),
              ProfileStatItem(
                value: favoritesCount.toString(),
                label: AppStrings.favs,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
