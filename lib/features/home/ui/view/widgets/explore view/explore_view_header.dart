import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../events/data/entities/event_query.dart';
import '../../../../../events/ui/view/search_view.dart';
import '../../../../../events/ui/view/widgets/filter/event_filter_bottom_sheet.dart';
import 'categories_list.dart';
import 'current_location_drop_down.dart';
import 'notification_icon_button.dart';
import 'search_bar_widget.dart';
import '../home_drawer_scope.dart';
import '../../../../data/entities/home_category_entity.dart';

class ExploreViewHeader extends StatelessWidget {
  const ExploreViewHeader({super.key, required this.categories});

  final List<HomeCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final backgroundHeight = MediaQuery.sizeOf(context).height * 0.22;

    return SizedBox(
      height: backgroundHeight + 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            Assets.assetsImagesHomeHeaderBg,
            height: backgroundHeight,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const .symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vGap(40),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    IconButton(
                      onPressed: HomeDrawerScope.of(context).openDrawer,
                      icon: SvgPicture.asset(
                        Assets.assetsImagesMenuIcon,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    CurrentLocationDropDown(),
                    NotificationIconButton(),
                  ],
                ),
                vGap(20),
                SearchBarWidget(
                  readOnly: true,
                  onTap: () => context.push(SearchView.routeName),
                  onFilterTap: () => _showFilters(context),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CategoriesList(
              categories: categories,
              onSelected: (category) => context.push(
                SearchView.routeName,
                extra: SearchViewArgs.category(
                  category: category,
                  categories: categories,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFilters(BuildContext context) async {
    final selection = await EventFilterBottomSheet.show(
      context,
      categories: categories,
    );
    if (selection == null || !context.mounted) return;

    context.push(
      SearchView.routeName,
      extra: SearchViewArgs(
        categories: categories,
        initialQuery: EventQuery(
          classificationName: selection.classificationName,
          datePreset: selection.datePreset,
          customDate: selection.customDate,
          minPrice: selection.minPrice,
          maxPrice: selection.maxPrice,
        ),
      ),
    );
  }
}
