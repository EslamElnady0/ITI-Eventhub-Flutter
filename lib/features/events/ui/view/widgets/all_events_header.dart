import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class AllEventsHeader extends StatelessWidget {
  const AllEventsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(
          style: ButtonStyle(
            iconSize: WidgetStateProperty.fromMap({WidgetState.any: 26}),
          ),
        ),

        Text(AppStrings.events, style: AppTextStyles.font24Bold),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: AppColors.black),
        ),
      ],
    );
  }
}
