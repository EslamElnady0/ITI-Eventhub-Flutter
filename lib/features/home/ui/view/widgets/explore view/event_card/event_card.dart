import 'package:flutter/material.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';
import 'event_card_image.dart';
import 'event_location_row.dart';
import '../../../../../data/entities/home_event_entity.dart';

class EventCard extends StatelessWidget {
  final VoidCallback onTap;
  final HomeEventEntity event;

  const EventCard({super.key, required this.onTap, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            EventCardImage(event: event),
            vGap(10),
            Padding(
              padding: const .symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.56,
                    child: Text(
                      event.title,
                      style: AppTextStyles.font18SemiBold,
                      maxLines: 1,
                      textAlign: .start,
                      overflow: .ellipsis,
                    ),
                  ),
                  vGap(8),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      event.dateLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font12Medium.withColor(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                  vGap(10),
                  EventLocationRow(location: event.location),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
