import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure_guard.dart';
import '../../../auth/data/entities/user_entity.dart';
import '../../../auth/data/repos/auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const ProfileState());

  final AuthRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      _repository.getCurrentUser,
      onSuccess: (user) {
        emit(
          state.copyWith(
            status: user == null
                ? ProfileStatus.failure
                : ProfileStatus.success,
            user: user,
            errorMessage: user == null ? 'Please sign in again.' : '',
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> updateAbout(String about) async {
    emit(state.copyWith(isSavingAbout: true, errorMessage: ''));
    await FailureGuard.handle(
      () => _repository.updateAbout(about),
      onSuccess: (user) {
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            user: user,
            isSavingAbout: false,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(isSavingAbout: false, errorMessage: failure.message),
        );
      },
    );
  }
}
