import 'package:flutter/material.dart';

import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/entities/event_entity.dart';
import 'event_info_item.dart';
import 'event_orgnizer_item.dart';

class EventInfoSection extends StatelessWidget {
  const EventInfoSection({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(event.title, style: AppTextStyles.font35Bold),
        vGap(18),
        EventInfoItem(
          iconPath: Assets.assetsImagesCalenderIcon,
          title: event.dateLabel,
          subTitle: event.timeLabel,
        ),
        vGap(16),
        EventInfoItem(
          iconPath: Assets.assetsImagesLocationIcon,
          title: event.venue,
          subTitle: event.locationLabel,
        ),
        vGap(24),
        EventOrganizerItem(
          imageUrl: event.organizerImageUrl,
          title: event.organizer,
          subTitle: event.category,
        ),
      ],
    );
  }
}
