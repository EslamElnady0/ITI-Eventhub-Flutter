import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../data/events_data.dart';
import 'event_details_view.dart';
import 'search_view.dart';
import 'widgets/events_list/events_list_app_bar.dart';
import 'widgets/search/horizontal_event_card.dart';

class EventsListView extends StatelessWidget {
  static const String routeName = '/events';

  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: EventsListAppBar(
        onBack: context.pop,
        onSearch: () => context.push(SearchView.routeName),
        onMore: () {},
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: EventsData.searchEvents.length,
        separatorBuilder: (context, index) => vGap(12),
        itemBuilder: (context, index) {
          return HorizontalEventCard(
            event: EventsData.searchEvents[index],
            onTap: () => context.push(EventDetailsView.routeName),
          );
        },
      ),
    );
  }
}
