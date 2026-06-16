import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/widgets/app_network_image.dart';
import '../../../../data/entities/event_entity.dart';
import '../../../cubit/favorites/favorites_cubit.dart';

class HorizontalEventCard extends StatelessWidget {
  final EventEntity event;
  final VoidCallback onTap;

  const HorizontalEventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: .circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(14),
        child: Container(
          padding: const .all(8),
          decoration: BoxDecoration(
            borderRadius: .circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: .circular(10),
                child: AppNetworkImage(
                  imageUrl: event.imageUrl,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                ),
              ),
              hGap(12),
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      '${event.dateLabel} - ${event.timeLabel}',
                      style: AppTextStyles.font12Medium
                          .withColor(AppColors.primaryColor)
                          .withFontSize(10),
                    ),
                    vGap(5),
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: AppTextStyles.font15Medium.withColor(
                        AppColors.black,
                      ),
                    ),
                    vGap(5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.darkGray,
                          size: 13,
                        ),
                        hGap(3),
                        Expanded(
                          child: Text(
                            event.locationLabel,
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: AppTextStyles.font12Medium
                                .withColor(AppColors.darkGray)
                                .withFontSize(10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocSelector<FavoritesCubit, FavoritesState, bool>(
                selector: (state) => state.favoriteIds.contains(event.id),
                builder: (context, isFavorite) {
                  return IconButton(
                    tooltip: isFavorite ? 'Remove favorite' : 'Save event',
                    onPressed: () =>
                        context.read<FavoritesCubit>().toggle(event),
                    icon: Icon(
                      isFavorite
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
