import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../data/entities/event_query.dart';
import '../cubit/events_list_cubit.dart';
import 'event_details_view.dart';
import 'search_view.dart';
import 'widgets/events_list/events_list_app_bar.dart';
import 'widgets/search/horizontal_event_card.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({super.key, required this.mode});

  static const String routeName = '/events';

  final EventListMode mode;

  @override
  State<EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
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
      appBar: EventsListAppBar(
        onBack: context.pop,
        onSearch: () => context.push(SearchView.routeName),
        onMore: () {},
      ),
      body: BlocBuilder<EventsListCubit, EventsListState>(
        builder: (context, state) {
          if (state.status == ListStatus.loading && state.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListStatus.failure && state.events.isEmpty) {
            return _ErrorView(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<EventsListCubit>().load(refresh: true),
            );
          }
          if (state.events.isEmpty) {
            return const Center(child: Text('No events found.'));
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.read<EventsListCubit>().load(refresh: true),
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: state.events.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => vGap(12),
              itemBuilder: (context, index) {
                if (index == state.events.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(),
                    ),
                  );
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
