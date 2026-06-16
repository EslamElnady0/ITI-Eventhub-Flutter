part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.rememberedUser,
    this.errorMessage = '',
  });

  final AuthStatus status;
  final UserEntity? user;
  final UserEntity? rememberedUser;
  final String errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    UserEntity? rememberedUser,
    String? errorMessage,
    bool clearUser = false,
    bool clearRememberedUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      rememberedUser: clearRememberedUser
          ? null
          : rememberedUser ?? this.rememberedUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, rememberedUser, errorMessage];
}
