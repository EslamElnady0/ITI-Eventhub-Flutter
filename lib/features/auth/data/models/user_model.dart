import '../entities/user_entity.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
  });

  final String id;
  final String name;
  final String email;
  final String about;

  factory UserModel.fromMap(Map<String, Object?> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      about: map['about'] as String? ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      about: entity.about,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'email': email, 'about': about};
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email, about: about);
  }
}
