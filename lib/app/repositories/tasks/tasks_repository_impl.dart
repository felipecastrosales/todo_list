import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final connection = await _sqliteConnectionFactory.openConnection();
    await connection.insert(
      'todo',
      {
        'id': null,
        'description': description,
        'date_hour': date.toIso8601String(),
        'finish': 0,
      },
    );
  }
}
