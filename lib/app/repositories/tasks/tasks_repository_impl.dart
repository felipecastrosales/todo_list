import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/models/task_model.dart';
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

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(
      start.year,
      start.month,
      start.day,
    );
    final endFilter = DateTime(
      start.year,
      start.month,
      start.day,
    );

    final connection = await _sqliteConnectionFactory.openConnection();
    final result = await connection.rawQuery(
      '''
        select * 
        from todo 
        where implementing_parameters_filter_home between ? and ?
        order by date_hour
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result
        .map(
          (e) => TaskModel.loadFromDB(e),
        )
        .toList();
  }
}
