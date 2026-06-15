import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../cubit/home_cubit.dart';
import 'widgets/explore view/call_to_action_section.dart';
import 'widgets/explore view/explore_view_header.dart';
import 'widgets/explore view/nearby_you_section.dart';
import 'widgets/explore view/upcomming_events_section.dart';

class ExploreView extends StatelessWidget {
  static const String routeName = '/explore';

  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: .start,
          children: [
            ExploreViewHeader(categories: state.categories),
            vGap(20),
            Expanded(child: _HomeBody(state: state)),
          ],
        );
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == HomeStatus.loading ||
        state.status == HomeStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == HomeStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.errorMessage, textAlign: TextAlign.center),
              vGap(12),
              FilledButton(
                onPressed: context.read<HomeCubit>().load,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: context.read<HomeCubit>().load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            UpComingEventsSection(events: state.upcomingEvents),
            vGap(24),
            const Padding(
              padding: .symmetric(horizontal: 20),
              child: CallToActionSection(),
            ),
            vGap(16),
            NearbyYouSection(events: state.nearbyEvents),
            vGap(24),
          ],
        ),
      ),
    );
  }
}
