import 'package:flutter/material.dart';
import '../../ui models/on_boarding_model.dart';

class BackgroundImagePageView extends StatelessWidget {
  final List<OnBoardingModel> onBoardingData;
  final PageController pageController;
  const BackgroundImagePageView({
    super.key,
    required this.onBoardingData,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: onBoardingData.length,
        itemBuilder: (context, index) {
          return Image.asset(
            onBoardingData[index].imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
