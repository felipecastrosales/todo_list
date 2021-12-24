import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [],
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
