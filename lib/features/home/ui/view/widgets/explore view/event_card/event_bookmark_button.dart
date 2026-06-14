import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../core/assets/assets.dart';
import '../../../../../../../core/theme/colors.dart';

class EventBookmarkButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EventBookmarkButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            Assets.assetsImagesBookmarkIcon,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.sportsCategory,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
