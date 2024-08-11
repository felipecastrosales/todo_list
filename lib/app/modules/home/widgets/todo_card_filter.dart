import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taskFilter,
    this.totalTasks,
    required this.selected,
  });

  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasks;
  final bool selected;

  double _getPercentFinish() {
    final total = totalTasks?.totalTasks ?? 0.0;
    final finish = totalTasks?.totalTasksFinish ?? 0.0;
    if (total == 0) {
      return 0.0;
    }
    final percent = (finish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: borderRadius,
      child: Container(
        height: 120,
        width: 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          borderRadius: borderRadius,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTasks?.totalTasks ?? 0} TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0.0,
                end: _getPercentFinish(),
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      selected ? Colors.white : context.primaryColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
