import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/theme/app_text_styles.dart';
import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/colors.dart';

class EventOrganizerItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;

  const EventOrganizerItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, width: 50, height: 50, fit: BoxFit.cover),
        hGap(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.font16Medium.withFontWeight(
                FontWeightHelper.regular,
              ),
            ),
            vGap(4),
            Text(
              subTitle,
              style: AppTextStyles.font12Medium.withColor(AppColors.darkGray),
            ),
          ],
        ),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primaryColorShade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            AppStrings.follow,
            style: AppTextStyles.font14Medium.withColor(AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
