import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/helpers/spacing.dart';
import 'package:iti_flutter_proj/core/theme/colors.dart';
import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../ui models/on_boarding_model.dart';
import 'page_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final List<OnBoardingModel> onBoardingData;
  final PageController pageController;
  const OnboardingBottomSection({
    super.key,
    required this.onBoardingData,
    required this.onNext,
    required this.onSkip,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: onBoardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          onBoardingData[index].title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font22SemiBold.withColor(
                            AppColors.white,
                          ),
                        ),
                        vGap(32),
                        Text(
                          onBoardingData[index].description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font18Regular.withColor(
                            AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onSkip,
                child: Text(
                  AppStrings.skip,
                  style: AppTextStyles.font18Regular.withColor(
                    AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              PageViewIndicator(
                count: onBoardingData.length,
                pageController: pageController,
              ),
              TextButton(
                onPressed: onNext,
                child: Text(
                  AppStrings.next,
                  style: AppTextStyles.font18Regular.withColor(AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
