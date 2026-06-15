import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/core/theme/app_text_styles.dart';
import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/app_network_image.dart';

class EventOrganizerItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;

  const EventOrganizerItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppNetworkImage(imageUrl: imageUrl, width: 50, height: 50),
        ),
        hGap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
        ),
        hGap(8),
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
