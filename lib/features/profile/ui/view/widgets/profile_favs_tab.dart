import 'package:flutter/material.dart';

import '../../../../events/data/entities/event_entity.dart';
import '../../../../events/ui/view/widgets/search/horizontal_event_card.dart';

class ProfileFavsTab extends StatelessWidget {
  const ProfileFavsTab({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  final List<EventEntity> events;
  final ValueChanged<EventEntity> onEventTap;

  static const List<EventEntity> defaultEvents = [];

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(child: Text('No saved events yet.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HorizontalEventCard(
            event: event,
            onTap: () => onEventTap(event),
          ),
        );
      },
    );
  }
}
