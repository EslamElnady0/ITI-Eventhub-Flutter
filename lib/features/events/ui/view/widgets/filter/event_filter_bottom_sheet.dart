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
import '../../../../data/entities/event_query.dart';

class EventFilterSelection {
  const EventFilterSelection({
    required this.classificationName,
    required this.datePreset,
    required this.customDate,
    required this.minPrice,
    required this.maxPrice,
  });

  final String classificationName;
  final EventDatePreset datePreset;
  final DateTime? customDate;
  final double? minPrice;
  final double? maxPrice;
}

class EventFilterBottomSheet extends StatefulWidget {
  const EventFilterBottomSheet({super.key});

  static Future<EventFilterSelection?> show(BuildContext context) {
    return showModalBottomSheet<EventFilterSelection>(
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
  int selectedCategoryIndex = -1;
  int selectedDateIndex = -1;
  RangeValues priceValues = const RangeValues(0, 150);
  DateTime? customDate;
  bool priceFilterEnabled = false;

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
              customDate: customDate,
              onSelected: (index) {
                setState(() {
                  selectedDateIndex = index;
                  customDate = null;
                });
              },
              onCustomDateSelected: (date) {
                setState(() {
                  customDate = date;
                  selectedDateIndex = -1;
                });
              },
            ),
            vGap(20),
            const FilterLocationTile(),
            vGap(20),
            FilterPriceRangeSection(
              values: priceValues,
              onChanged: (values) {
                setState(() {
                  priceValues = values;
                  priceFilterEnabled = true;
                });
              },
            ),
            vGap(24),
            FilterActionButtons(
              onReset: resetFilters,
              onApply: () => Navigator.pop(
                context,
                EventFilterSelection(
                  classificationName: _classificationName,
                  datePreset: _datePreset,
                  customDate: customDate,
                  minPrice: priceFilterEnabled ? priceValues.start : null,
                  maxPrice: priceFilterEnabled ? priceValues.end : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetFilters() {
    setState(() {
      selectedCategoryIndex = -1;
      selectedDateIndex = -1;
      priceValues = const RangeValues(0, 150);
      customDate = null;
      priceFilterEnabled = false;
    });
  }

  String get _classificationName {
    const values = ['sports', 'music', 'Arts & Theatre', 'Food & Drink'];
    if (selectedCategoryIndex < 0 || selectedCategoryIndex >= values.length) {
      return '';
    }
    return values[selectedCategoryIndex];
  }

  EventDatePreset get _datePreset {
    if (customDate != null) return EventDatePreset.custom;
    switch (selectedDateIndex) {
      case 0:
        return EventDatePreset.today;
      case 1:
        return EventDatePreset.tomorrow;
      case 2:
        return EventDatePreset.thisWeek;
      default:
        return EventDatePreset.any;
    }
  }
}
