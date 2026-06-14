import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import 'widgets/explore view/call_to_action_section.dart';
import 'widgets/explore view/explore_view_header.dart';
import 'widgets/explore view/nearby_you_section.dart';
import 'widgets/explore view/upcomming_events_section.dart';

class ExploreView extends StatelessWidget {
  static const String routeName = '/explore';

  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        ExploreViewHeader(),
        vGap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                UpComingEventsSection(),
                vGap(24),
                Padding(
                  padding: const .symmetric(horizontal: 20),
                  child: CallToActionSection(),
                ),
                vGap(16),
                NearbyYouSection(),
                vGap(24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
