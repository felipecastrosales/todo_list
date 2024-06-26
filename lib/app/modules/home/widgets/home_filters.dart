import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/app_constants.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceBetween =
        SizedBox(width: AppConstants.defaultComponentPaddingHorizontalSide / 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.defaultComponentPadding,
          child: Text(
            'FILTROS',
            style: context.titleStyle,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: AppConstants.defaultComponentPaddingHorizontalSide,
              ),
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasks: context.select<HomeController, TotalTasksModel?>(
                  (value) => value.todayTotalTasks,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              spaceBetween,
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasks: context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.tomorrowTotalTasks,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              spaceBetween,
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasks: context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.weekTotalTasks,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
              spaceBetween,
            ],
          ),
        ),
      ],
    );
  }
}
