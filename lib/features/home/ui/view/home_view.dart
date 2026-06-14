import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iti_flutter_proj/core/widgets/custom_scaffold.dart';

import 'widgets/home_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      ignoreTopSafeArea: true,
      body: navigationShell,
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
