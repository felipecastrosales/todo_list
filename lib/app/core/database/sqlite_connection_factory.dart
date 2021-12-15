import 'package:synchronized/synchronized.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST';
  static SqliteConnectionFactory? _instance;
  SqliteConnectionFactory._();
  Database? _db;
  final _lock = Lock();

  factory SqliteConnectionFactory() {
    // if (_instance == null) { _instance = SqliteConnectionFactory._(); }
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        // if (_db == null) { _db = ... }  
        _db ??= await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {}

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {}
}
