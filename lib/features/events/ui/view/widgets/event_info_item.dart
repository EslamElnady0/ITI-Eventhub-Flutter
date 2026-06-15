import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_flutter_proj/core/theme/app_text_styles.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/colors.dart';

class EventInfoItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;

  const EventInfoItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColorShade100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(iconPath),
        ),
        hGap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.font16Medium),
              vGap(4),
              Text(
                subTitle,
                style: AppTextStyles.font12Medium.withColor(AppColors.darkGray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
