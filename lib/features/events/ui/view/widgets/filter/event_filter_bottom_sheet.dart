import 'package:flutter/material.dart';

import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import 'filter_action_buttons.dart';
import 'filter_categories_list.dart';
import 'filter_date_section.dart';
import 'filter_location_tile.dart';
import 'filter_price_range_section.dart';

class EventFilterBottomSheet extends StatefulWidget {
  const EventFilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EventFilterBottomSheet(),
    );
  }

  @override
  State<EventFilterBottomSheet> createState() => EventFilterBottomSheetState();
}

class EventFilterBottomSheetState extends State<EventFilterBottomSheet> {
  int selectedCategoryIndex = 0;
  int selectedDateIndex = 1;
  RangeValues priceValues = const RangeValues(20, 120);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.82,
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.paddingOf(context).bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              child: SizedBox(
                width: 34,
                child: Divider(thickness: 3, color: AppColors.gray),
              ),
            ),
            Text(AppStrings.filter, style: AppTextStyles.font24Bold),
            vGap(18),
            FilterCategoriesList(
              selectedIndex: selectedCategoryIndex,
              onSelected: (index) {
                setState(() => selectedCategoryIndex = index);
              },
            ),
            vGap(16),
            FilterDateSection(
              selectedIndex: selectedDateIndex,
              onSelected: (index) {
                setState(() => selectedDateIndex = index);
              },
            ),
            vGap(20),
            const FilterLocationTile(),
            vGap(20),
            FilterPriceRangeSection(
              values: priceValues,
              onChanged: (values) {
                setState(() => priceValues = values);
              },
            ),
            vGap(24),
            FilterActionButtons(
              onReset: resetFilters,
              onApply: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void resetFilters() {
    setState(() {
      selectedCategoryIndex = 0;
      selectedDateIndex = 1;
      priceValues = const RangeValues(20, 120);
    });
  }
}
