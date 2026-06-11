import 'package:go_router/go_router.dart';

import '../../features/auth/ui/view/login_view.dart';
import '../../features/auth/ui/view/signup_view.dart';
import '../../features/onboarding/ui/view/onboarding_view.dart';
import '../../features/splash/ui/splash_view.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: OnboardingView.routeName,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: LoginView.routeName,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: SignupView.routeName,
        builder: (context, state) => const SignupView(),
      ),
    ],
  );
}
