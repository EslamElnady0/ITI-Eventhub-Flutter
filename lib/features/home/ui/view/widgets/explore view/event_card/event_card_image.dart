import 'package:flutter/material.dart';

import '../../../../../../../core/assets/assets.dart';
import 'event_bookmark_button.dart';
import 'event_date_badge.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            Assets.assetsImagesEvent1,
            height: MediaQuery.sizeOf(context).height * 0.16,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const PositionedDirectional(top: 8, start: 8, child: EventDateBadge()),
        PositionedDirectional(
          top: 8,
          end: 8,
          child: EventBookmarkButton(onPressed: () {}),
        ),
      ],
    );
  }
}
