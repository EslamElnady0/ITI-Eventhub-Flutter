import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure_guard.dart';
import '../../data/entities/user_entity.dart';
import '../../data/repos/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  Future<bool> restoreSession() async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: ''));
    var isAuthenticated = false;
    await FailureGuard.handle(
      () async {
        final rememberedUser = await _repository.getRememberedUser();
        final isLoggedIn = await _repository.isLoggedIn();
        final user = isLoggedIn ? await _repository.getCurrentUser() : null;
        return (
          rememberedUser: rememberedUser,
          isLoggedIn: isLoggedIn,
          user: user,
        );
      },
      onSuccess: (session) {
        switch ((session.isLoggedIn, session.user)) {
          case (true, final user?):
            isAuthenticated = true;
            emit(
              state.copyWith(
                status: AuthStatus.authenticated,
                user: user,
                rememberedUser: session.rememberedUser,
              ),
            );
          default:
            emit(
              state.copyWith(
                status: AuthStatus.unauthenticated,
                rememberedUser: session.rememberedUser,
                clearUser: true,
              ),
            );
        }
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
            clearUser: true,
          ),
        );
      },
    );
    return isAuthenticated;
  }

  Future<void> loadRememberedUser() async {
    await FailureGuard.handle(
      _repository.getRememberedUser,
      onSuccess: (rememberedUser) {
        emit(
          state.copyWith(
            rememberedUser: rememberedUser,
            clearRememberedUser: rememberedUser == null,
          ),
        );
      },
      onFailure: (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      () => _repository.signup(name: name, email: email, password: password),
      onSuccess: (user) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
            clearUser: true,
          ),
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      () => _repository.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      ),
      onSuccess: (user) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            rememberedUser: rememberMe ? user : null,
            clearRememberedUser: !rememberMe,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
            clearUser: true,
          ),
        );
      },
    );
  }

  Future<void> quickLogin() async {
    final rememberedUser = state.rememberedUser;
    switch (rememberedUser) {
      case null:
        return;
      default:
    }

    emit(state.copyWith(status: AuthStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      () => _repository.quickLogin(rememberedUser.id),
      onSuccess: (user) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
            clearUser: true,
            clearRememberedUser: true,
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    final rememberedUser = await _repository.getRememberedUser();
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        rememberedUser: rememberedUser,
        clearUser: true,
        clearRememberedUser: rememberedUser == null,
      ),
    );
  }
}
