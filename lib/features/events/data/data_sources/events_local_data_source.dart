import 'package:sqflite/sqflite.dart';

import '../../../../core/helpers/local_db_helper.dart';
import '../entities/event_entity.dart';
import '../models/event_local_model.dart';

abstract class EventsLocalDataSource {
  Future<List<EventEntity>> getFavoriteEvents(String userId);

  Future<Set<String>> getFavoriteEventIds(String userId);

  Future<void> addFavorite({
    required String userId,
    required EventEntity event,
  });

  Future<void> removeFavorite({
    required String userId,
    required String eventId,
  });
}

class EventsLocalDataSourceImpl implements EventsLocalDataSource {
  const EventsLocalDataSourceImpl(this._dbHelper);

  static const String _favoritesTable = 'favorite_events';

  final LocalDbHelper _dbHelper;

  @override
  Future<List<EventEntity>> getFavoriteEvents(String userId) async {
    final rows = await _dbHelper.query(
      _favoritesTable,
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return rows.map((row) => EventLocalModel.fromMap(row).toEntity()).toList();
  }

  @override
  Future<Set<String>> getFavoriteEventIds(String userId) async {
    final rows = await _dbHelper.query(
      _favoritesTable,
      columns: ['event_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return rows
        .map((row) => row['event_id'] as String? ?? '')
        .where((id) => id.isNotEmpty)
        .toSet();
  }

  @override
  Future<void> addFavorite({
    required String userId,
    required EventEntity event,
  }) async {
    await _dbHelper.insert(
      _favoritesTable,
      EventLocalModel.fromEntity(event).toMap(userId: userId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite({
    required String userId,
    required String eventId,
  }) async {
    await _dbHelper.delete(
      _favoritesTable,
      where: 'user_id = ? AND event_id = ?',
      whereArgs: [userId, eventId],
    );
  }
}
