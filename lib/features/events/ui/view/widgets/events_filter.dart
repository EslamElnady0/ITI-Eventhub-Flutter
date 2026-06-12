import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class EventsFilter extends StatelessWidget {
  const EventsFilter({
    super.key,
    required this.showUpcomingEvents,
    required this.onChanged,
  });

  final bool showUpcomingEvents;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: _FilterItem(
              label: AppStrings.upcoming,
              isSelected: showUpcomingEvents,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _FilterItem(
              label: AppStrings.pastEvents,
              isSelected: !showUpcomingEvents,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  const _FilterItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.withColor(
                isSelected ? AppColors.primaryColor : AppColors.darkGray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
