import 'package:flutter/material.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';

class EventLocationRow extends StatelessWidget {
  const EventLocationRow({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: AppColors.darkGray, size: 18),
        hGap(5),
        Expanded(
          child: Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Regular.withColor(AppColors.darkGray),
          ),
        ),
      ],
    );
  }
}
