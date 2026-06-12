import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class FloatingEngagedPeopleView extends StatelessWidget {
  const FloatingEngagedPeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    double avatarRaduis = 18;
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: avatarRaduis,
                backgroundImage: AssetImage(Assets.assetsImagesManAvatar),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: avatarRaduis * 1.3),
                child: CircleAvatar(
                  radius: avatarRaduis,
                  backgroundImage: AssetImage(Assets.assetsImagesWomanAvatar),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: avatarRaduis * 1.3 * 2,
                ),
                child: CircleAvatar(
                  radius: avatarRaduis,
                  backgroundImage: AssetImage(Assets.assetsImagesManAvatar),
                ),
              ),
            ],
          ),
          hGap(8),
          Text(
            AppStrings.going(120),
            style: AppTextStyles.font16Medium
                .copyWith(color: AppColors.primaryColor)
                .withFontWeight(FontWeight.bold),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(AppStrings.invite),
          ),
        ],
      ),
    );
  }
}
