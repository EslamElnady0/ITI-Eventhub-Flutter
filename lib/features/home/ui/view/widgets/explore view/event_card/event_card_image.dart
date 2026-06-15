import 'package:flutter/material.dart';

import '../../../../../../../core/widgets/app_network_image.dart';
import '../../../../../data/entities/home_event_entity.dart';
import 'event_bookmark_button.dart';
import 'event_date_badge.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({super.key, required this.event});

  final HomeEventEntity event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AppNetworkImage(
            imageUrl: event.imageUrl,
            height: MediaQuery.sizeOf(context).height * 0.16,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 8,
          start: 8,
          child: EventDateBadge(day: event.day, month: event.month),
        ),
        PositionedDirectional(
          top: 8,
          end: 8,
          child: EventBookmarkButton(onPressed: () {}),
        ),
      ],
    );
  }
}
