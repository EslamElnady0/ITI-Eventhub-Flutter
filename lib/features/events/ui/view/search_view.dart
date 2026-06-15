import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../home/ui/view/widgets/explore view/search_bar_widget.dart';
import '../cubit/search_cubit.dart';
import 'event_details_view.dart';
import 'widgets/filter/event_filter_bottom_sheet.dart';
import 'widgets/search/horizontal_event_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static const String routeName = '/events/search';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
        ),
        title: Text(
          AppStrings.searchTitle,
          style: AppTextStyles.font20SemiBold.withColor(AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: context.read<SearchCubit>().keywordChanged,
              foregroundColor: AppColors.primaryColor,
              hintColor: AppColors.darkGray.withValues(alpha: 0.55),
              dividerColor: AppColors.gray,
              filterBackgroundColor: AppColors.primaryColor,
              filterForegroundColor: AppColors.white,
              onFilterTap: _showFilters,
            ),
            vGap(16),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) => _buildResults(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(SearchState state) {
    if (state.status == SearchStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == SearchStatus.failure) {
      return _SearchMessage(
        message: state.errorMessage,
        actionLabel: 'Retry',
        onAction: context.read<SearchCubit>().refresh,
      );
    }
    if (state.events.isEmpty) {
      return const Center(child: Text('No events match your search.'));
    }

    return RefreshIndicator(
      onRefresh: context.read<SearchCubit>().refresh,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
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

  Future<void> _showFilters() async {
    final selection = await EventFilterBottomSheet.show(context);
    if (selection == null || !mounted) return;
    await context.read<SearchCubit>().applyFilters(
      classificationName: selection.classificationName,
      datePreset: selection.datePreset,
      customDate: selection.customDate,
      minPrice: selection.minPrice,
      maxPrice: selection.maxPrice,
    );
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300) {
      context.read<SearchCubit>().loadMore();
    }
  }
}

class _SearchMessage extends StatelessWidget {
  const _SearchMessage({
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          vGap(12),
          FilledButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}
