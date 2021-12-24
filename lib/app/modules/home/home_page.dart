import 'package:flutter/material.dart';

import 'package:todo_list/app/core/auth/auth_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('logout'),
          onPressed: () {
            context.read<AuthProvider>().logout();
          },
        ),
      ),
    );
  }
}
