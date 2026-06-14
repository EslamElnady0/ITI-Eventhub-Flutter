import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/ui/view/widgets/explore view/search_bar_widget.dart';
import '../../data/events_data.dart';
import 'event_details_view.dart';
import 'widgets/filter/event_filter_bottom_sheet.dart';
import 'widgets/search/horizontal_event_card.dart';

class SearchView extends StatelessWidget {
  static const String routeName = '/events/search';

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              foregroundColor: AppColors.primaryColor,
              hintColor: AppColors.darkGray.withValues(alpha: 0.55),
              dividerColor: AppColors.gray,
              filterBackgroundColor: AppColors.primaryColor,
              filterForegroundColor: AppColors.white,
              onFilterTap: () => EventFilterBottomSheet.show(context),
            ),
            vGap(16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: EventsData.searchEvents.length,
                separatorBuilder: (context, index) => vGap(12),
                itemBuilder: (context, index) {
                  return HorizontalEventCard(
                    event: EventsData.searchEvents[index],
                    onTap: () => context.push(EventDetailsView.routeName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
