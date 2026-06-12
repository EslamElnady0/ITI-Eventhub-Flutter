import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/about_event_section.dart';
import 'widgets/event_details_header.dart';
import 'widgets/event_info_section.dart';

class EventDetailsView extends StatelessWidget {
  static const String routeName = '/event-details';
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      ignoreTopSafeArea: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventDetailsHeader(),
                vGap(MediaQuery.sizeOf(context).height * 0.04 + 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventInfoSection(),
                      vGap(24),
                      AboutEventSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
