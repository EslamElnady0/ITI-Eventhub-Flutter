import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/widgets/custom_button.dart';
import '../../events/data/entities/event_entity.dart';
import '../../events/ui/cubit/favorites/favorites_cubit.dart';
import '../../events/ui/view/event_details_view.dart';
import '../../events/ui/view/widgets/search/horizontal_event_card.dart';

class EventMarkerPreviewSheet extends StatelessWidget {
  final EventEntity event;
  const EventMarkerPreviewSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoritesCubit>(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HorizontalEventCard(
                event: event,
                onTap: () =>
                    context.push('${EventDetailsView.routeName}/${event.id}'),
              ),
              const SizedBox(height: 12),
              CustomButton(
                onPressed: () =>
                    context.push('${EventDetailsView.routeName}/${event.id}'),
                label: 'View details',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
