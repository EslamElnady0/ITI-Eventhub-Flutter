import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  static const String _databaseName = 'event_hub.db';
  static const int _databaseVersion = 2;

  Database? _database;

  Future<Database> get database async {
    final existingDatabase = _database;
    if (existingDatabase != null) return existingDatabase;

    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _databaseName);
    final openedDatabase = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    _database = openedDatabase;
    return openedDatabase;
  }

  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final db = await database;
    return db.insert(table, values, conflictAlgorithm: conflictAlgorithm);
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final db = await database;
    return db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;
    return db.rawQuery(sql, arguments);
  }

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return db.transaction(action);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        about TEXT NOT NULL DEFAULT ''
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_events (
        user_id TEXT NOT NULL,
        event_id TEXT NOT NULL,
        title TEXT NOT NULL,
        image_url TEXT NOT NULL,
        date_time TEXT NOT NULL,
        date_label TEXT NOT NULL,
        time_label TEXT NOT NULL,
        venue TEXT NOT NULL,
        address TEXT NOT NULL,
        location_label TEXT NOT NULL,
        organizer TEXT NOT NULL,
        organizer_image_url TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        min_price REAL NOT NULL,
        max_price REAL NOT NULL,
        currency TEXT NOT NULL,
        price_label TEXT NOT NULL,
        has_price INTEGER NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        distance REAL NOT NULL,
        distance_label TEXT NOT NULL,
        ticket_url TEXT NOT NULL,
        PRIMARY KEY(user_id, event_id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS favorite_events');
      await db.execute('''
        CREATE TABLE favorite_events (
          user_id TEXT NOT NULL,
          event_id TEXT NOT NULL,
          title TEXT NOT NULL,
          image_url TEXT NOT NULL,
          date_time TEXT NOT NULL,
          date_label TEXT NOT NULL,
          time_label TEXT NOT NULL,
          venue TEXT NOT NULL,
          address TEXT NOT NULL,
          location_label TEXT NOT NULL,
          organizer TEXT NOT NULL,
          organizer_image_url TEXT NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          min_price REAL NOT NULL,
          max_price REAL NOT NULL,
          currency TEXT NOT NULL,
          price_label TEXT NOT NULL,
          has_price INTEGER NOT NULL,
          latitude REAL NOT NULL,
          longitude REAL NOT NULL,
          distance REAL NOT NULL,
          distance_label TEXT NOT NULL,
          ticket_url TEXT NOT NULL,
          PRIMARY KEY(user_id, event_id)
        )
      ''');
    }
  }
}
