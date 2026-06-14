import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/ui/view/login_view.dart';
import '../../features/auth/ui/view/signup_view.dart';
import '../../features/events/ui/view/all_events_view.dart';
import '../../features/events/ui/view/events_list_view.dart';
import '../../features/events/ui/view/search_view.dart';
import '../../features/home/ui/view/explore_view.dart';
import '../../features/home/ui/view/home_view.dart';
import '../../features/map/map_view.dart';
import '../../features/profile/ui/view/profile_view.dart';
import '../../features/onboarding/ui/view/onboarding_view.dart';
import '../../features/splash/ui/splash_view.dart';

Page<void> _buildPageWithTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: animation.drive(tween), child: child),
      );
    },
  );
}

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const SplashView()),
      ),
      GoRoute(
        path: OnboardingView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const OnboardingView()),
      ),
      GoRoute(
        path: LoginView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const LoginView()),
      ),
      GoRoute(
        path: SignupView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const SignupView()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ExploreView.routeName,
                builder: (context, state) => const ExploreView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AllEventsView.routeName,
                builder: (context, state) => const AllEventsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MapView.routeName,
                builder: (context, state) => const MapView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProfileView.routeName,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: SearchView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const SearchView()),
      ),
      GoRoute(
        path: EventsListView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const EventsListView()),
      ),
    ],
  );
}
