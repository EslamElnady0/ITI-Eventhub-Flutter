import 'package:sqflite/sqflite.dart';

import '../../../../core/helpers/local_db_helper.dart';
import '../entities/user_entity.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> createUser(UserEntity user);

  Future<UserEntity?> getUserByEmail(String email);

  Future<UserEntity?> getUserById(String userId);

  Future<UserEntity> updateAbout({
    required String userId,
    required String about,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._dbHelper);

  static const String _usersTable = 'users';

  final LocalDbHelper _dbHelper;

  @override
  Future<void> createUser(UserEntity user) async {
    await _dbHelper.insert(
      _usersTable,
      UserModel.fromEntity(user).toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    final rows = await _dbHelper.query(
      _usersTable,
      where: 'email = ?',
      whereArgs: [_normalizeEmail(email)],
      limit: 1,
    );
    return rows.isEmpty ? null : UserModel.fromMap(rows.first).toEntity();
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    final rows = await _dbHelper.query(
      _usersTable,
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return rows.isEmpty ? null : UserModel.fromMap(rows.first).toEntity();
  }

  @override
  Future<UserEntity> updateAbout({
    required String userId,
    required String about,
  }) async {
    await _dbHelper.update(
      _usersTable,
      {'about': about.trim()},
      where: 'id = ?',
      whereArgs: [userId],
    );
    final user = await getUserById(userId);
    if (user == null) {
      throw StateError('User was not found.');
    }
    return user;
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();
}
