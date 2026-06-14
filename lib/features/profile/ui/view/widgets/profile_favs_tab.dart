import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../events/data/events_data.dart';
import '../../../../events/ui/models/event_model.dart';
import '../../../../events/ui/view/widgets/search/horizontal_event_card.dart';

class ProfileFavsTab extends StatelessWidget {
  final List<EventModel> events;
  final ValueChanged<EventModel> onEventTap;

  const ProfileFavsTab({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: events.length,
      separatorBuilder: (context, index) => vGap(12),
      itemBuilder: (context, index) {
        final event = events[index];
        return HorizontalEventCard(
          event: event,
          onTap: () => onEventTap(event),
        );
      },
    );
  }

  static List<EventModel> get defaultEvents =>
      EventsData.searchEvents.toList(growable: false);
}
