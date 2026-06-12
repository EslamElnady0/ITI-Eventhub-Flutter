import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/ui/view/login_view.dart';
import '../../features/auth/ui/view/signup_view.dart';
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
    ],
  );
}
