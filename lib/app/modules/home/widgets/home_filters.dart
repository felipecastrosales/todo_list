import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filters',
          style: context.titleStyle,
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasks: TotalTasksModel(
                  totalTasks: 8,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected,
                ) == TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasks: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 4,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected,
                ) == TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'SEGUNDA',
                taskFilter: TaskFilterEnum.week,
                totalTasks: TotalTasksModel(
                  totalTasks: 7,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected,
                ) == TaskFilterEnum.week,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
