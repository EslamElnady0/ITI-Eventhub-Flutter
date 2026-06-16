import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../events/ui/cubit/favorites/favorites_cubit.dart';
import '../../../events/ui/view/event_details_view.dart';
import '../cubit/profile_cubit.dart';
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
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, profileState) {
            if (profileState.status == ProfileStatus.loading ||
                profileState.status == ProfileStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = profileState.user;
            if (profileState.status == ProfileStatus.failure || user == null) {
              return Center(
                child: FilledButton(
                  onPressed: context.read<ProfileCubit>().load,
                  child: const Text('Retry'),
                ),
              );
            }

            return BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favoritesState) {
                return Column(
                  children: [
                    vGap(28),
                    ProfileHeader(
                      name: user.name,
                      email: user.email,
                      favoritesCount: favoritesState.events.length,
                    ),
                    vGap(24),
                    const ProfileTabBar(),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ProfileAboutTab(
                            about: user.about,
                            isSaving: profileState.isSavingAbout,
                            onSave: context.read<ProfileCubit>().updateAbout,
                          ),
                          ProfileFavsTab(
                            events: favoritesState.events,
                            onEventTap: (event) {
                              context.push(
                                '${EventDetailsView.routeName}/${event.id}',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
