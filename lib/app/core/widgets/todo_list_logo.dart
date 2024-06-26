import 'package:flutter/material.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({
    super.key,
    required this.size,
    this.fontSize,
  });

  final double size;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final titleLarge = context.textTheme.titleLarge;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: size,
        ),
        Text(
          'Todo List',
          style: fontSize != null
              ? titleLarge?.copyWith(fontSize: fontSize)
              : titleLarge,
        ),
      ],
    );
  }
}
