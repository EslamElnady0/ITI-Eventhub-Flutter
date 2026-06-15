import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../data/entities/event_query.dart';
import '../cubit/events_list_cubit.dart';
import 'event_details_view.dart';
import 'search_view.dart';
import 'widgets/all_events_header.dart';
import 'widgets/empty_events_state.dart';
import 'widgets/events_filter.dart';
import 'widgets/search/horizontal_event_card.dart';

class AllEventsView extends StatefulWidget {
  const AllEventsView({super.key});

  static const String routeName = '/all-events';

  @override
  State<AllEventsView> createState() => _AllEventsViewState();
}

class _AllEventsViewState extends State<AllEventsView> {
  bool _showUpcomingEvents = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const AllEventsHeader(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(60, 8, 60, 24),
        child: CustomButton(
          label: AppStrings.exploreEvents,
          onPressed: () => context.push(SearchView.routeName),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            vGap(16),
            EventsFilter(
              showUpcomingEvents: _showUpcomingEvents,
              onChanged: (showUpcomingEvents) {
                setState(() => _showUpcomingEvents = showUpcomingEvents);
                context.read<EventsListCubit>().changeMode(
                  showUpcomingEvents
                      ? EventListMode.upcoming
                      : EventListMode.past,
                );
              },
            ),
            Expanded(
              child: BlocBuilder<EventsListCubit, EventsListState>(
                builder: (context, state) => _buildBody(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(EventsListState state) {
    if (state.status == ListStatus.loading && state.events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == ListStatus.failure && state.events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.errorMessage, textAlign: TextAlign.center),
              vGap(12),
              FilledButton(
                onPressed: () =>
                    context.read<EventsListCubit>().load(refresh: true),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (state.events.isEmpty) {
      return EmptyEventsState(
        title: _showUpcomingEvents
            ? AppStrings.noUpcomingEvent
            : AppStrings.noPastEvent,
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<EventsListCubit>().load(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: state.events.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => vGap(12),
        itemBuilder: (context, index) {
          if (index == state.events.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final event = state.events[index];
          return HorizontalEventCard(
            event: event,
            onTap: () =>
                context.push('${EventDetailsView.routeName}/${event.id}'),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300) {
      context.read<EventsListCubit>().load();
    }
  }
}
