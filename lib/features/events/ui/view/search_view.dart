import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../data/entities/event_query.dart';
import '../../../home/data/entities/home_category_entity.dart';
import '../../../home/ui/view/widgets/explore view/search_bar_widget.dart';
import '../cubit/search/search_cubit.dart';
import 'event_details_view.dart';
import 'widgets/filter/event_filter_bottom_sheet.dart';
import 'widgets/search/horizontal_event_card.dart';

class SearchViewArgs {
  const SearchViewArgs({
    this.initialQuery = const EventQuery(),
    this.categories = const [],
  });

  factory SearchViewArgs.category({
    required HomeCategoryEntity category,
    required List<HomeCategoryEntity> categories,
  }) {
    return SearchViewArgs(
      initialQuery: EventQuery(classificationName: category.apiName),
      categories: categories,
    );
  }

  final EventQuery initialQuery;
  final List<HomeCategoryEntity> categories;
}

class SearchView extends StatefulWidget {
  const SearchView({super.key, this.categories = const []});

  static const String routeName = '/events/search';

  final List<HomeCategoryEntity> categories;

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
            BlocBuilder<SearchCubit, SearchState>(
              buildWhen: (previous, current) => previous.query != current.query,
              builder: (context, state) {
                return _ActiveFiltersBar(
                  query: state.query,
                  categories: widget.categories,
                );
              },
            ),
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
    final state = context.read<SearchCubit>().state;
    final selection = await EventFilterBottomSheet.show(
      context,
      categories: widget.categories,
      initialQuery: state.query,
    );
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

class _ActiveFiltersBar extends StatelessWidget {
  const _ActiveFiltersBar({required this.query, required this.categories});

  final EventQuery query;
  final List<HomeCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      if (query.classificationName.trim().isNotEmpty)
        _FilterChipLabel(label: _categoryLabel(query.classificationName)),
      if (query.datePreset != EventDatePreset.any)
        _FilterChipLabel(label: _dateLabel(query)),
      if (query.hasPriceFilter)
        _FilterChipLabel(
          label: '\$${query.minPrice!.round()} - \$${query.maxPrice!.round()}',
        ),
    ];

    if (chips.isEmpty) return vGap(16);

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(spacing: 8, runSpacing: 8, children: chips),
      ),
    );
  }

  String _categoryLabel(String classificationName) {
    for (final category in categories) {
      if (category.apiName == classificationName) return category.name;
    }
    switch (classificationName) {
      case 'sports':
        return AppStrings.sports;
      case 'music':
        return AppStrings.music;
      case 'Food & Drink':
        return AppStrings.food;
      case 'Arts & Theatre':
        return AppStrings.art;
    }
    return classificationName;
  }

  String _dateLabel(EventQuery query) {
    switch (query.datePreset) {
      case EventDatePreset.today:
        return AppStrings.today;
      case EventDatePreset.tomorrow:
        return AppStrings.tomorrow;
      case EventDatePreset.thisWeek:
        return AppStrings.thisWeek;
      case EventDatePreset.custom:
        final date = query.customDate;
        if (date == null) return AppStrings.chooseFromCalendar;
        return '${date.day}/${date.month}/${date.year}';
      case EventDatePreset.any:
        return '';
    }
  }
}

class _FilterChipLabel extends StatelessWidget {
  const _FilterChipLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: AppTextStyles.font12Medium.withColor(AppColors.primaryColor),
        ),
      ),
    );
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
