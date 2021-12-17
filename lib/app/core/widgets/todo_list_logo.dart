import 'package:flutter/material.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  final double size;
  const TodoListLogo({Key? key, required this.size}) : super(key: key);

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
          style: context.textTheme.headline6,
        ),
      ],
    );
  }
}
