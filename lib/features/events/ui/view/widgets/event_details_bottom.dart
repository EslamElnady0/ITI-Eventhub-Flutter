import 'package:flutter/material.dart';
import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';

class EventDetailsBottom extends StatelessWidget {
  const EventDetailsBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 52,
        right: 52,
        top: 72,
        bottom: MediaQuery.paddingOf(context).bottom + 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withValues(alpha: 0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.6, 1.0],
        ),
      ),
      child: CustomButton(
        label: AppStrings.buyTicket("\$120"),
        onPressed: () {},
      ),
    );
  }
}
