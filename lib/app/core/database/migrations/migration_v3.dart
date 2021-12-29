import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
    create table test2(
      id integer
    )
    ''');
  }

  @override
  void update(Batch batch) {
    batch.execute('''
    create table teste2(
      id integer
    )
    ''');
  }
}
