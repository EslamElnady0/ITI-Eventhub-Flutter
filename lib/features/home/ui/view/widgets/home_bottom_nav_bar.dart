import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';
import '../../models/bottom_nav_bar_item_model.dart';
import 'nav_icon.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<BottomNavBarItemModel> _items = [
    BottomNavBarItemModel(
      text: AppStrings.explore,
      icon: Assets.assetsImagesCompass,
    ),
    BottomNavBarItemModel(
      text: AppStrings.events,
      icon: Assets.assetsImagesCalendarBottomNavIcon,
    ),
    BottomNavBarItemModel(
      text: AppStrings.map,
      icon: Assets.assetsImagesLocationCottomNavIcon,
    ),
    BottomNavBarItemModel(
      text: AppStrings.profile,
      icon: Assets.assetsImagesProfileBottomNavIcon,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.darkGray,
      selectedLabelStyle: AppTextStyles.font12Medium,
      unselectedLabelStyle: AppTextStyles.font12Medium,
      items: [
        ..._items.map(
          (item) => BottomNavigationBarItem(
            label: item.text,
            icon: NavBarIcon(
              path: item.icon,
              color: _items.indexOf(item) == currentIndex
                  ? AppColors.primaryColor
                  : AppColors.darkGray,
            ),
          ),
        ),
      ],
    );
  }
}
