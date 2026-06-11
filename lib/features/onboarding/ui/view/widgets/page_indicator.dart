import 'package:flutter/widgets.dart';

import '../../../../../core/theme/colors.dart';

class PageViewIndicator extends StatefulWidget {
  final int count;
  final PageController pageController;

  const PageViewIndicator({
    super.key,
    required this.count,
    required this.pageController,
  });

  @override
  State<PageViewIndicator> createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  void _updateUI() {
    setState(() {});
  }

  @override
  void initState() {
    widget.pageController.addListener(_updateUI);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_updateUI);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.pageController.hasClients
        ? widget.pageController.page?.round() ?? 0
        : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.count,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 8,
          height: currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
