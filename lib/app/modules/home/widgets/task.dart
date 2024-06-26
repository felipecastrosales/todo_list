import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/app_constants.dart';

import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.model,
  });

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');

    return Container(
      margin: AppConstants.defaultComponentPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.grey[300]!,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
          leading: Checkbox(
            value: model.finished,
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(model),
          ),
          title: Text(
            model.description,
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
