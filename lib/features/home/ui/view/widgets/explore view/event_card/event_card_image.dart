import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/app_network_image.dart';
import '../../../../../../events/data/entities/event_entity.dart';
import '../../../../../../events/ui/cubit/favorites/favorites_cubit.dart';
import '../../../../../data/entities/home_event_entity.dart';
import 'event_bookmark_button.dart';
import 'event_date_badge.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({super.key, required this.event});

  final HomeEventEntity event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AppNetworkImage(
            imageUrl: event.imageUrl,
            height: MediaQuery.sizeOf(context).height * 0.16,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 8,
          start: 8,
          child: EventDateBadge(day: event.day, month: event.month),
        ),
        PositionedDirectional(
          top: 8,
          end: 8,
          child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
            selector: (state) => state.favoriteIds.contains(event.id),
            builder: (context, isFavorite) {
              return EventBookmarkButton(
                isFavorite: isFavorite,
                onPressed: () => context.read<FavoritesCubit>().toggle(
                  _toFavoriteEvent(event),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  EventEntity _toFavoriteEvent(HomeEventEntity event) {
    return EventEntity(
      id: event.id,
      title: event.title,
      imageUrl: event.imageUrl,
      dateTime: DateTime.fromMillisecondsSinceEpoch(0),
      dateLabel: event.dateLabel,
      timeLabel: '',
      venue: event.location,
      address: event.location,
      locationLabel: event.location,
      organizer: 'Ticketmaster Event',
      organizerImageUrl: '',
      description: 'No additional event information is available.',
      category: 'Event',
      minPrice: 0,
      maxPrice: 0,
      currency: 'USD',
      priceLabel: 'See ticket options',
      hasPrice: false,
      latitude: 0,
      longitude: 0,
      distance: 0,
      distanceLabel: event.distanceLabel,
      ticketUrl: '',
    );
  }
}
