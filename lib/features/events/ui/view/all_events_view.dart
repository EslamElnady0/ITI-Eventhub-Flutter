import 'package:flutter/material.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/all_events_header.dart';
import 'widgets/empty_events_state.dart';
import 'widgets/events_filter.dart';

class AllEventsView extends StatefulWidget {
  static const String routeName = '/all-events';

  const AllEventsView({super.key});

  @override
  State<AllEventsView> createState() => _AllEventsViewState();
}

class _AllEventsViewState extends State<AllEventsView> {
  bool _showUpcomingEvents = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const AllEventsHeader(),
            vGap(12),
            EventsFilter(
              showUpcomingEvents: _showUpcomingEvents,
              onChanged: (showUpcomingEvents) {
                setState(() => _showUpcomingEvents = showUpcomingEvents);
              },
            ),
            Expanded(
              child: EmptyEventsState(
                title: _showUpcomingEvents
                    ? AppStrings.noUpcomingEvent
                    : AppStrings.noPastEvent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: MediaQuery.paddingOf(context).bottom + 24,
              ),
              child: CustomButton(
                label: AppStrings.exploreEvents,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
