import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/failure_guard.dart';
import '../../../../core/helpers/local_storage_helper.dart';
import '../data_sources/auth_local_data_source.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<UserEntity> quickLogin(String userId);

  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<UserEntity?> getCurrentUser();

  Future<UserEntity?> getRememberedUser();

  Future<UserEntity> updateAbout(String about);
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._localDataSource,
    this._storageHelper,
    this._uuid,
  );

  final AuthLocalDataSource _localDataSource;
  final LocalStorageHelper _storageHelper;
  final Uuid _uuid;

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    return FailureGuard.run(
      () async {
        final normalizedEmail = _normalizeEmail(email);
        final existingUser = await _localDataSource.getUserByEmail(
          normalizedEmail,
        );
        if (existingUser != null) {
          throw const AppFailure('An account with this email already exists.');
        }

        final user = UserEntity(
          id: _uuid.v4(),
          name: name.trim(),
          email: normalizedEmail,
          about: '',
        );
        await _localDataSource.createUser(user);
        await _storageHelper.writeSecure(
          _AuthStorageKeys.password(user.id),
          password,
        );
        await _startSession(user.id);
        return user;
      },
      onError: (error) {
        if (error is DatabaseException && error.isUniqueConstraintError()) {
          return const AppFailure('An account with this email already exists.');
        }
        return null;
      },
    );
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return FailureGuard.run(() async {
      final user = await _localDataSource.getUserByEmail(email);
      if (user == null) throw _invalidCredentialsFailure;

      final storedPassword = await _storageHelper.readSecure(
        _AuthStorageKeys.password(user.id),
      );
      if (storedPassword != password) throw _invalidCredentialsFailure;

      await _startSession(user.id);
      await _setRememberedUserId(rememberMe ? user.id : null);
      return user;
    });
  }

  @override
  Future<UserEntity> quickLogin(String userId) async {
    return FailureGuard.run(() async {
      final user = await _localDataSource.getUserById(userId);
      if (user == null) {
        await _setRememberedUserId(null);
        throw const AppFailure('Remembered account is no longer available.');
      }
      await _startSession(user.id);
      return user;
    });
  }

  @override
  Future<void> logout() async {
    await _storageHelper.setBool(_AuthStorageKeys.isLoggedIn, false);
    await _setCurrentUserId(null);
  }

  @override
  Future<bool> isLoggedIn() async {
    if (!(_storageHelper.getBool(_AuthStorageKeys.isLoggedIn) ?? false)) {
      return false;
    }
    final userId = _storageHelper.getString(_AuthStorageKeys.currentUserId);
    if (userId == null) return false;
    final user = await _localDataSource.getUserById(userId);
    return user != null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userId = _storageHelper.getString(_AuthStorageKeys.currentUserId);
    if (userId == null ||
        !(_storageHelper.getBool(_AuthStorageKeys.isLoggedIn) ?? false)) {
      return null;
    }
    return _localDataSource.getUserById(userId);
  }

  @override
  Future<UserEntity?> getRememberedUser() async {
    final userId = _storageHelper.getString(_AuthStorageKeys.rememberedUserId);
    if (userId == null) return null;
    final user = await _localDataSource.getUserById(userId);
    if (user == null) {
      await _setRememberedUserId(null);
    }
    return user;
  }

  @override
  Future<UserEntity> updateAbout(String about) async {
    return FailureGuard.run(() async {
      final userId = _storageHelper.getString(_AuthStorageKeys.currentUserId);
      if (userId == null ||
          !(_storageHelper.getBool(_AuthStorageKeys.isLoggedIn) ?? false)) {
        throw const AppFailure('Please sign in again.');
      }
      return _localDataSource.updateAbout(userId: userId, about: about);
    });
  }

  Future<void> _startSession(String userId) async {
    await _storageHelper.setBool(_AuthStorageKeys.isLoggedIn, true);
    await _setCurrentUserId(userId);
  }

  Future<void> _setCurrentUserId(String? userId) async {
    if (userId == null || userId.isEmpty) {
      await _storageHelper.remove(_AuthStorageKeys.currentUserId);
      return;
    }
    await _storageHelper.setString(_AuthStorageKeys.currentUserId, userId);
  }

  Future<void> _setRememberedUserId(String? userId) async {
    if (userId == null || userId.isEmpty) {
      await _storageHelper.remove(_AuthStorageKeys.rememberedUserId);
      return;
    }
    await _storageHelper.setString(_AuthStorageKeys.rememberedUserId, userId);
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  static const AppFailure _invalidCredentialsFailure = AppFailure(
    'Invalid email or password.',
  );
}

class _AuthStorageKeys {
  const _AuthStorageKeys._();

  static const String isLoggedIn = 'is_logged_in';
  static const String currentUserId = 'current_user_id';
  static const String rememberedUserId = 'remembered_user_id';

  static String password(String userId) => 'user_password_$userId';
}
