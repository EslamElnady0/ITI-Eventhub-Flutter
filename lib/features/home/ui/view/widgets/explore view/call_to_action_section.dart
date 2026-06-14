import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class CallToActionSection extends StatelessWidget {
  const CallToActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.assetsImagesBannerBg,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        PositionedDirectional(
          start: 20,
          top: 20,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                AppStrings.inviteYourFriends,
                style: AppTextStyles.font18SemiBold,
              ),
              Text(
                AppStrings.get20ForTicket,
                style: AppTextStyles.font14Regular.withColor(
                  AppColors.darkGray,
                ),
              ),
              vGap(8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: .circular(8)),
                ),
                child: Text(
                  AppStrings.invite,
                  style: AppTextStyles.font14Regular.withColor(AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
