import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../data/entities/user_entity.dart';
import '../../cubit/auth_cubit.dart';
import 'remembered_user_card.dart';

class RememberedUserSection extends StatelessWidget {
  const RememberedUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AuthCubit,
      AuthState,
      ({bool isLoading, UserEntity? user})
    >(
      selector: (state) => (
        user: state.rememberedUser,
        isLoading: state.status == AuthStatus.loading,
      ),
      builder: (context, state) {
        final user = state.user;
        if (user == null) return const SizedBox.shrink();
        return Column(
          children: [
            vGap(16),
            RememberedUserCard(
              user: user,
              isLoading: state.isLoading,
              onTap: () {
                if (!state.isLoading) {
                  context.read<AuthCubit>().quickLogin();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
