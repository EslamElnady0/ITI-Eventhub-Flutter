import 'package:flutter/material.dart';

import '../../../../../../../core/assets/app_strings.dart';
import '../../../../../../../core/assets/assets.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';

class EventAttendeesRow extends StatelessWidget {
  const EventAttendeesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarRadius = MediaQuery.sizeOf(context).width * 0.03;

    return Row(
      children: [
        SizedBox(
          width: avatarRadius * 4.6,
          height: avatarRadius * 2,
          child: Stack(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const AssetImage(Assets.assetsImagesManAvatar),
              ),
              PositionedDirectional(
                start: avatarRadius * 1.3,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage(
                    Assets.assetsImagesWomanAvatar,
                  ),
                ),
              ),
              PositionedDirectional(
                start: avatarRadius * 2.6,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage(
                    Assets.assetsImagesManAvatar,
                  ),
                ),
              ),
            ],
          ),
        ),
        hGap(8),
        Text(
          AppStrings.going(120),
          style: AppTextStyles.font16Medium
              .withColor(AppColors.primaryColor)
              .withFontWeight(FontWeight.bold),
        ),
      ],
    );
  }
}
