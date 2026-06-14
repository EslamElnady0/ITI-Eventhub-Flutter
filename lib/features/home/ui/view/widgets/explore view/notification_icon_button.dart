import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iti_flutter_proj/core/assets/assets.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      padding: const .all(0),
      icon: Container(
        padding: const .all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.2),
        ),
        child: Badge(
          backgroundColor: Colors.cyan,
          child: SvgPicture.asset(
            Assets.assetsImagesBellIcon,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
