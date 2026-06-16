import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iti_flutter_proj/core/widgets/custom_scaffold.dart';

import '../../../auth/ui/cubit/auth_cubit.dart';
import '../../../events/ui/cubit/favorites/favorites_cubit.dart';
import '../../../../core/theme/colors.dart';
import '../../../auth/ui/view/login_view.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_drawer_scope.dart';
import 'widgets/home_bottom_nav_bar.dart';

class HomeView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeView({super.key, required this.navigationShell});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _drawerController,
      backdropColor: AppColors.white,
      openRatio: 0.72,
      openScale: 0.86,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 24,
          ),
        ],
      ),
      drawer: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = state.user;
          return HomeDrawer(
            displayName: user?.name ?? 'Guest',
            displayEmail: user?.email,
            onProfileTap: () => _goToBranch(3),
            onCalendarTap: () => _goToBranch(1),
            onSignOutTap: () async {
              _drawerController.hideDrawer();
              await context.read<AuthCubit>().logout();
              if (!context.mounted) return;
              await context.read<FavoritesCubit>().load();
              if (!context.mounted) return;
              context.go(LoginView.routeName);
            },
          );
        },
      ),
      child: HomeDrawerScope(
        openDrawer: _drawerController.showDrawer,
        child: CustomScaffold(
          ignoreTopSafeArea: true,
          body: widget.navigationShell,
          bottomNavigationBar: HomeBottomNavBar(
            currentIndex: widget.navigationShell.currentIndex,
            onTap: _goToBranch,
          ),
        ),
      ),
    );
  }

  void _goToBranch(int index) {
    _drawerController.hideDrawer();
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
