import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';
import 'package:iti_flutter_proj/core/di/service_locator.dart';
import 'package:iti_flutter_proj/core/helpers/local_storage_helper.dart';
import 'package:iti_flutter_proj/core/widgets/custom_scaffold.dart';

import '../../auth/ui/cubit/auth_cubit.dart';
import '../../auth/ui/view/login_view.dart';
import '../../home/ui/view/explore_view.dart';
import '../../onboarding/ui/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      final isLoggedIn = await context.read<AuthCubit>().restoreSession();
      if (!mounted) return;
      if (isLoggedIn) {
        context.go(ExploreView.routeName);
      } else {
        final hasViewedOnboarding =
            getIt<LocalStorageHelper>().getBool(OnboardingView.isViewedKey) ??
            false;
        context.go(
          hasViewedOnboarding ? LoginView.routeName : OnboardingView.routeName,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Image.asset(Assets.assetsImagesLogo, width: 250, height: 200),
      ),
    );
  }
}
