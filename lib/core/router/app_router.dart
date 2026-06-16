import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/events/data/entities/event_query.dart';
import '../../features/events/ui/cubit/details/event_details_cubit.dart';
import '../../features/events/ui/cubit/events_list/events_list_cubit.dart';
import '../../features/events/ui/cubit/favorites/favorites_cubit.dart';
import '../../features/events/ui/cubit/search/search_cubit.dart';
import '../../features/auth/ui/cubit/auth_cubit.dart';
import '../../features/auth/ui/view/login_view.dart';
import '../../features/auth/ui/view/signup_view.dart';
import '../../features/events/ui/view/all_events_view.dart';
import '../../features/events/ui/view/event_details_view.dart';
import '../../features/events/ui/view/events_list_view.dart';
import '../../features/events/ui/view/search_view.dart';
import '../../features/home/ui/view/explore_view.dart';
import '../../features/home/ui/view/home_view.dart';
import '../../features/map/map_view.dart';
import '../../features/profile/ui/cubit/profile_cubit.dart';
import '../../features/profile/ui/view/profile_view.dart';
import '../../features/onboarding/ui/view/onboarding_view.dart';
import '../../features/splash/ui/splash_view.dart';
import '../../features/home/ui/cubit/home_cubit.dart';
import '../di/service_locator.dart';

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
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const SplashView(),
          ),
        ),
      ),
      GoRoute(
        path: OnboardingView.routeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context, state, const OnboardingView()),
      ),
      GoRoute(
        path: LoginView.routeName,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginView(),
          ),
        ),
      ),
      GoRoute(
        path: SignupView.routeName,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const SignupView(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<AuthCubit>()..restoreSession()),
              BlocProvider.value(value: getIt<FavoritesCubit>()..load()),
            ],
            child: HomeView(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ExploreView.routeName,
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<HomeCubit>()..load(),
                  child: const ExploreView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AllEventsView.routeName,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<EventsListCubit>(param1: EventListMode.upcoming)
                        ..load(),
                  child: const AllEventsView(),
                ),
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
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<ProfileCubit>()..load(),
                  child: const ProfileView(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '${EventDetailsView.routeName}/:eventId',
        pageBuilder: (context, state) {
          final eventId = state.pathParameters['eventId'] ?? '';
          return _buildPageWithTransition(
            context,
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => getIt<EventDetailsCubit>()..load(eventId),
                ),
                BlocProvider.value(value: getIt<FavoritesCubit>()..load()),
              ],
              child: EventDetailsView(eventId: eventId),
            ),
          );
        },
      ),
      GoRoute(
        path: SearchView.routeName,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<SearchCubit>()..loadInitial()),
              BlocProvider.value(value: getIt<FavoritesCubit>()..load()),
            ],
            child: const SearchView(),
          ),
        ),
      ),
      GoRoute(
        path: EventsListView.routeName,
        pageBuilder: (context, state) {
          final rawMode = state.uri.queryParameters['mode'];
          final mode = rawMode == EventListMode.nearby.name
              ? EventListMode.nearby
              : EventListMode.upcoming;
          return _buildPageWithTransition(
            context,
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => getIt<EventsListCubit>(param1: mode)..load(),
                ),
                BlocProvider.value(value: getIt<FavoritesCubit>()..load()),
              ],
              child: EventsListView(mode: mode),
            ),
          );
        },
      ),
    ],
  );
}
