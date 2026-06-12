import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/about_event_section.dart';
import 'widgets/event_bottom_bottom.dart';
import 'widgets/event_details_header.dart';
import 'widgets/event_info_section.dart';

class EventDetailsView extends StatelessWidget {
  static const String routeName = '/event-details';
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      ignoreTopSafeArea: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const EventDetailsHeader(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vGap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EventInfoSection(),
                          vGap(24),
                          const AboutEventSection(),
                          vGap(140),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: EventDetailsBottom(),
          ),
        ],
      ),
    );
  }
}
