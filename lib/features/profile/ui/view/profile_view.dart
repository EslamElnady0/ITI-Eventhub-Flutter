import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../events/ui/view/event_details_view.dart';
import 'widgets/profile_about_tab.dart';
import 'widgets/profile_favs_tab.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tab_bar.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            vGap(28),
            const ProfileHeader(),
            vGap(24),
            const ProfileTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  const ProfileAboutTab(),
                  ProfileFavsTab(
                    events: ProfileFavsTab.defaultEvents,
                    onEventTap: (event) {
                      context.push('${EventDetailsView.routeName}/${event.id}');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
