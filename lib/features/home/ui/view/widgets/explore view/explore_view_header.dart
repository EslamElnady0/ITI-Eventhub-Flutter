import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

import '../../../../../../core/helpers/spacing.dart';
import 'categories_list.dart';
import 'current_location_drop_down.dart';
import 'notification_icon_button.dart';
import 'search_bar_widget.dart';
import '../home_drawer_scope.dart';

class ExploreViewHeader extends StatelessWidget {
  const ExploreViewHeader({super.key});

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
                SearchBarWidget(),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CategoriesList(),
          ),
        ],
      ),
    );
  }
}
