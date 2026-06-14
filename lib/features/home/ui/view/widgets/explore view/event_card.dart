import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/assets/assets.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    var avatarRaduis = MediaQuery.sizeOf(context).width * 0.03;
    return Container(
      padding: const .all(10),
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).width * 0.6,
      margin: const .symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: .start,
        children: [
          Stack(
            children: [
              Image.asset(
                Assets.assetsImagesEvent1,
                height: MediaQuery.sizeOf(context).height * 0.16,
                fit: .fill,
              ),
            ],
          ),
          vGap(10),
          Padding(
            padding: const .symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: .start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.56,
                  child: Text(
                    AppStrings.internationalBandMusicConcert,
                    style: AppTextStyles.font18SemiBold,
                    maxLines: 1,
                    textAlign: .start,
                    overflow: .ellipsis,
                  ),
                ),
                vGap(8),
                Row(
                  mainAxisAlignment: .start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: avatarRaduis,
                          backgroundImage: AssetImage(
                            Assets.assetsImagesManAvatar,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: avatarRaduis * 1.3,
                          ),
                          child: CircleAvatar(
                            radius: avatarRaduis,
                            backgroundImage: AssetImage(
                              Assets.assetsImagesWomanAvatar,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: avatarRaduis * 1.3 * 2,
                          ),
                          child: CircleAvatar(
                            radius: avatarRaduis,
                            backgroundImage: AssetImage(
                              Assets.assetsImagesManAvatar,
                            ),
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
                  ],
                ),
                vGap(10),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.darkGray,
                      size: 18,
                    ),
                    hGap(5),
                    Text(
                      AppStrings.guildStreetLondon,
                      style: AppTextStyles.font14Regular.withColor(
                        AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
