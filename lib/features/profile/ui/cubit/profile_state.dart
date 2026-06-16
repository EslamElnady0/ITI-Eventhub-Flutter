part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.isSavingAbout = false,
    this.errorMessage = '',
  });

  final ProfileStatus status;
  final UserEntity? user;
  final bool isSavingAbout;
  final String errorMessage;

  ProfileState copyWith({
    ProfileStatus? status,
    UserEntity? user,
    bool? isSavingAbout,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      isSavingAbout: isSavingAbout ?? this.isSavingAbout,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, isSavingAbout, errorMessage];
}
