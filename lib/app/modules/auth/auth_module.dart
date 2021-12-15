import 'package:provider/provider.dart';

import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'package:todo_list/app/core/modules/todo_list_module.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (_) => LoginController(),
          ),
        ], routers: {
          '/login': (context) => const LoginPage(),
        });
}
