import 'package:flutter/material.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'modules/auth/auth_module.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var sqliteAdmConnection = SqliteAdmConnection();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        ...AuthModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
