import 'package:provider/provider.dart';

import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';
import 'package:todo_list/app/services/tasks/tasks_service_impl.dart';
import 'tasks_create_controller.dart';
import 'tasks_create_page.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                sqliteConnectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                tasksRepository: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => TasksCreateController(
                tasksService: context.read(),
              ),
            ),
          ],
          routers: {
            '/task/create': (context) => TasksCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
