import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/app_constants.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: AppConstants.defaultComponentPadding,
                child: Selector<HomeController, String>(
                  selector: (context, controller) =>
                      controller.filterSelected.description,
                  builder: (context, value, child) {
                    return Text(
                      'TASK\'S $value',
                      style: context.titleStyle,
                    );
                  },
                ),
              ),
            ],
          ),
          Selector<HomeController, List<TaskModel>>(
            selector: (context, controller) => controller.filteredTasks,
            builder: (context, tasks, child) {
              return Column(
                children: tasks.map((t) => Task(model: t)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
