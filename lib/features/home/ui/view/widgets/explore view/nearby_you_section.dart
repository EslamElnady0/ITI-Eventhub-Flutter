import 'package:flutter/material.dart';
import '../../../../../../core/assets/app_strings.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import 'event_card.dart';

class NearbyYouSection extends StatelessWidget {
  const NearbyYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: .symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(AppStrings.nearbyYou, style: AppTextStyles.font20Bold),
              IconButton(
                padding: .zero,
                onPressed: () {},
                icon: Row(
                  children: [
                    Text(
                      AppStrings.seeAll,
                      style: AppTextStyles.font14Regular.withColor(
                        AppColors.darkGray,
                      ),
                    ),
                    hGap(4),
                    Icon(
                      Icons.arrow_forward_sharp,
                      size: 18,
                      color: AppColors.darkGray,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.31,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const .symmetric(horizontal: 20),
            itemCount: 5,
            separatorBuilder: (context, index) => hGap(12),
            itemBuilder: (context, index) {
              return EventCard();
            },
          ),
        ),
      ],
    );
  }
}
