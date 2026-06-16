import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helpers/local_storage_helper.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../auth/ui/view/login_view.dart';
import '../ui models/on_boarding_model.dart';
import 'widgets/background_image_page_view.dart';
import 'widgets/onboarding_bottom_section.dart';

class OnboardingView extends StatefulWidget {
  static const String routeName = '/onboarding';
  static const String isViewedKey = 'is_onboarding_viewed';

  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();

  static List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
      imagePath: Assets.assetsImagesFirstOnboarding,
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDescription1,
    ),
    OnBoardingModel(
      imagePath: Assets.assetsImagesSecondOnboarding,
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDescription2,
    ),
    OnBoardingModel(
      imagePath: Assets.assetsImagesThirdOnboarding,
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDescription3,
    ),
  ];
}

class _OnboardingViewState extends State<OnboardingView> {
  int _currentIndex = 0;
  late PageController _imagePageController;
  late PageController _contentPageController;

  @override
  initState() {
    _imagePageController = PageController(initialPage: 0);
    _contentPageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  dispose() {
    _imagePageController.dispose();
    _contentPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: BackgroundImagePageView(
              onBoardingData: OnboardingView.onBoardingData,
              pageController: _imagePageController,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OnboardingBottomSection(
              onBoardingData: OnboardingView.onBoardingData,
              pageController: _contentPageController,
              onNext: _onNext,
              onSkip: _onSkip,
            ),
          ),
        ],
      ),
    );
  }

  _onNext() {
    if (_currentIndex < OnboardingView.onBoardingData.length - 1) {
      _currentIndex++;
      _imagePageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _contentPageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _onSkip() => _finishOnboarding();

  Future<void> _finishOnboarding() async {
    await getIt<LocalStorageHelper>().setBool(OnboardingView.isViewedKey, true);
    if (!mounted) return;
    context.go(LoginView.routeName);
  }
}
