import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/event_details_header.dart';

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
              children: [EventDetailsHeader()],
            ),
          ),
        ],
      ),
    );
  }
}
