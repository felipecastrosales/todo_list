import 'package:flutter/material.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: size,
        ),
        Text(
          'Todo List',
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
