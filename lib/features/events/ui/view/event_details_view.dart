import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_scaffold.dart';

class EventDetailsView extends StatelessWidget {
  static const String routeName = '/event-details';
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Event Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            vGap(20),
          ],
        ),
      ),
    );
  }
}
