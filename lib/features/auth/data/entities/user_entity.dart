import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
  });

  final String id;
  final String name;
  final String email;
  final String about;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? about,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
    );
  }

  @override
  List<Object?> get props => [id, name, email, about];
}
