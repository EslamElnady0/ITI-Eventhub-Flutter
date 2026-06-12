import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'event_info_item.dart';
import 'event_orgnizer_item.dart';

class EventInfoSection extends StatelessWidget {
  const EventInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.internationalBandMusicConcert,
          style: AppTextStyles.font35Bold,
        ),
        vGap(18),
        EventInfoItem(
          iconPath: Assets.assetsImagesCalenderIcon,
          title: AppStrings.eventDate,
          subTitle: AppStrings.eventTime,
        ),
        vGap(16),
        EventInfoItem(
          iconPath: Assets.assetsImagesLocationIcon,
          title: AppStrings.eventLocation,
          subTitle: AppStrings.eventAddress,
        ),
        vGap(24),
        EventOrganizerItem(
          iconPath: Assets.assetsImagesOrgnizerPlaceholder,
          title: AppStrings.organizerName,
          subTitle: AppStrings.organizerRole,
        ),
      ],
    );
  }
}
