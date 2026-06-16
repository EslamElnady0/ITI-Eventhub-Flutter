import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../data/entities/event_entity.dart';
import '../cubit/details/event_details_cubit.dart';
import 'widgets/about_event_section.dart';
import 'widgets/event_details_bottom.dart';
import 'widgets/event_details_header.dart';
import 'widgets/event_info_section.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.eventId});

  static const String routeName = '/event-details';

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      ignoreTopSafeArea: true,
      body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          if (state.status == DetailsStatus.loading ||
              state.status == DetailsStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == DetailsStatus.failure || state.event == null) {
            return _DetailsError(
              message: state.errorMessage,
              onRetry: () => context.read<EventDetailsCubit>().load(eventId),
            );
          }
          return _DetailsContent(event: state.event!);
        },
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            EventDetailsHeader(event: event),
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
                        EventInfoSection(event: event),
                        vGap(24),
                        AboutEventSection(description: event.description),
                        vGap(140),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: EventDetailsBottom(
            priceLabel: event.priceLabel,
            onBuyTicket: () => _openTicket(context),
          ),
        ),
      ],
    );
  }

  Future<void> _openTicket(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('To be implemented: Open ticket link in browser'),
        ),
      );
    }
  }
}

class _DetailsError extends StatelessWidget {
  const _DetailsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, textAlign: TextAlign.center),
              vGap(12),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
