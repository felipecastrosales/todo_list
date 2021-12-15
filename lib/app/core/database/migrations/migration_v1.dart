import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
    create table todo(
      id Integer primary key autoincrement,
      desciption varchar(500) not null,
      date_hour datetime, 
      finish integer
    )
    ''');
  }

  @override
  void update(Batch batch) {
  }
}
