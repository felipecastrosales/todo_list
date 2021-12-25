import 'package:provider/provider.dart';

import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'tasks_create_controller.dart';
import 'tasks_create_page.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => TasksCreateController(),
            ),
          ],
          routers: {
            '/task/create': (context) => TasksCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
