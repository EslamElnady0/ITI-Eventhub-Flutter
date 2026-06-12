import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

import 'floating_engaged_people_view.dart';
import 'header_action_bar.dart';

class EventDetailsHeader extends StatelessWidget {
  const EventDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          Assets.assetsImagesEventImage,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.3,
          fit: BoxFit.cover,
        ),
        HeaderActionBar(),
        Positioned(
          right: 0,
          left: 0,
          top: MediaQuery.sizeOf(context).height * 0.26,
          child: FloatingEngagedPeopleView(),
        ),
      ],
    );
  }
}
