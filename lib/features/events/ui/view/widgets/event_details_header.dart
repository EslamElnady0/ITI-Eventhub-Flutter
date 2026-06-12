import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';
import 'floating_engaged_people_view.dart';

class EventDetailsHeader extends StatelessWidget {
  const EventDetailsHeader({super.key});

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
  });

  final double minHeaderExtent;
  final double maxHeaderExtent;
  final double topPadding;

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
                child: Image.asset(
                  Assets.assetsImagesEventImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
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
            child: const _ExpandedActionBar(),
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
              child: const _CompactActionBar(),
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
        topPadding != oldDelegate.topPadding;
  }
}

class _ExpandedActionBar extends StatelessWidget {
  const _ExpandedActionBar();

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
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class _CompactActionBar extends StatelessWidget {
  const _CompactActionBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        ClipOval(
          child: Image.asset(
            Assets.assetsImagesEventImage,
            width: 42,
            height: 42,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            AppStrings.internationalBandMusicConcert,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font16Medium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 8, end: 12),
          child: _BookmarkButton(
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
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.bookmark, color: foregroundColor, size: 22),
        ),
      ),
    );
  }
}
