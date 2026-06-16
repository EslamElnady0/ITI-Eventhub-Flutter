import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';
import '../../../data/entities/user_entity.dart';

class RememberedUserCard extends StatelessWidget {
  const RememberedUserCard({
    super.key,
    required this.user,
    required this.isLoading,
    required this.onTap,
  });

  final UserEntity user;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initial = user.name.trim().isEmpty
        ? '?'
        : user.name.trim()[0].toUpperCase();

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: Text(
                  initial,
                  style: AppTextStyles.font20SemiBold.withColor(
                    AppColors.primaryColor,
                  ),
                ),
              ),
              hGap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Medium.withColor(
                        AppColors.black,
                      ),
                    ),
                    vGap(4),
                    Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Medium.withColor(
                        AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.login, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
