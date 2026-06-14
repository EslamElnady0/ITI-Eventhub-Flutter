import 'package:flutter/material.dart';

import '../../../../../../../core/assets/app_strings.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../core/theme/colors.dart';

class EventLocationRow extends StatelessWidget {
  const EventLocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: AppColors.darkGray, size: 18),
        hGap(5),
        Expanded(
          child: Text(
            AppStrings.guildStreetLondon,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Regular.withColor(AppColors.darkGray),
          ),
        ),
      ],
    );
  }
}
