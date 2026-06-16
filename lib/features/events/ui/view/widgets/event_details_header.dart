import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../data/entities/event_entity.dart';
import '../../cubit/favorites/favorites_cubit.dart';
import 'floating_engaged_people_view.dart';

class EventDetailsHeader extends StatelessWidget {
  const EventDetailsHeader({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _EventDetailsHeaderDelegate(
        minHeaderExtent: topPadding + 68,
        maxHeaderExtent: (screenHeight * 0.26).clamp(280.0, 360.0) + 48,
        topPadding: topPadding,
        event: event,
      ),
    );
  }
}

class _EventDetailsHeaderDelegate extends SliverPersistentHeaderDelegate {
  static const double _floatingViewBottomInset = 4;
  static const double _imageBottomInset = 36;

  const _EventDetailsHeaderDelegate({
    required this.minHeaderExtent,
    required this.maxHeaderExtent,
    required this.topPadding,
    required this.event,
  });

  final double minHeaderExtent;
  final double maxHeaderExtent;
  final double topPadding;
  final EventEntity event;

  @override
  double get minExtent => minHeaderExtent;

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final collapseRange = maxExtent - minExtent;
    final progress = collapseRange == 0
        ? 1.0
        : (shrinkOffset / collapseRange).clamp(0.0, 1.0);
    final expandedOpacity = (1 - progress * 1.7).clamp(0.0, 1.0);
    final compactOpacity = ((progress - 0.55) / 0.45).clamp(0.0, 1.0);

    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.white),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: _imageBottomInset,
          child: ClipRect(
            child: Opacity(
              opacity: 1 - progress,
              child: Transform.scale(
                scale: 1 + (progress * 0.08),
                child: AppNetworkImage(
                  imageUrl: event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: _imageBottomInset,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withValues(alpha: 0.48 * (1 - progress)),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: topPadding,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: expandedOpacity,
            child: _ExpandedActionBar(event: event),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: _floatingViewBottomInset,
          child: IgnorePointer(
            ignoring: progress > 0.4,
            child: Opacity(
              opacity: expandedOpacity,
              child: Transform.translate(
                offset: Offset(0, progress * 18),
                child: Transform.scale(
                  scale: 1 - (progress * 0.08),
                  child: const FloatingEngagedPeopleView(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: topPadding,
          left: 0,
          right: 0,
          height: 68,
          child: IgnorePointer(
            ignoring: compactOpacity == 0,
            child: Opacity(
              opacity: compactOpacity,
              child: _CompactActionBar(event: event),
            ),
          ),
        ),
        if (overlapsContent || progress > 0.98)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(height: 1),
          ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant _EventDetailsHeaderDelegate oldDelegate) {
    return minHeaderExtent != oldDelegate.minHeaderExtent ||
        maxHeaderExtent != oldDelegate.maxHeaderExtent ||
        topPadding != oldDelegate.topPadding ||
        event != oldDelegate.event;
  }
}

class _ExpandedActionBar extends StatelessWidget {
  const _ExpandedActionBar({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(color: AppColors.white),
        Text(
          AppStrings.eventDetails,
          style: AppTextStyles.font24Bold.copyWith(color: AppColors.white),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          child: _BookmarkButton(
            event: event,
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class _CompactActionBar extends StatelessWidget {
  const _CompactActionBar({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        ClipOval(
          child: AppNetworkImage(
            imageUrl: event.imageUrl,
            width: 42,
            height: 42,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            event.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font16Medium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8, end: 12),
          child: _BookmarkButton(
            event: event,
            foregroundColor: AppColors.primaryColor,
            backgroundColor: Color(0xFFF1F0FF),
          ),
        ),
      ],
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({
    required this.event,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final EventEntity? event;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final event = this.event;
    if (event == null) return const SizedBox.shrink();

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
        selector: (state) => state.favoriteIds.contains(event.id),
        builder: (context, isFavorite) {
          return InkWell(
            onTap: () => context.read<FavoritesCubit>().toggle(event),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: foregroundColor,
                size: 22,
              ),
            ),
          );
        },
      ),
    );
  }
}
