import 'package:flutter/material.dart';

import '../../../../../../../core/theme/colors.dart';

class EventBookmarkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isFavorite;

  const EventBookmarkButton({
    super.key,
    required this.onPressed,
    required this.isFavorite,
  });

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
          child: Icon(
            isFavorite ? Icons.bookmark : Icons.bookmark_border,
            size: 18,
            color: AppColors.sportsCategory,
          ),
        ),
      ),
    );
  }
}
