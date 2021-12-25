import 'package:flutter/material.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'tasks_create_controller.dart';
import 'widgets/calendar_button.dart';

class TasksCreatePage extends StatelessWidget {
  TasksCreateController _controller;
  TasksCreatePage({Key? key, required TasksCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Criar task',
                style: context.titleStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              TodoListField(label: ''),
              const SizedBox(height: 10),
              const CalendarButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        label: const Text(
          'Salvar task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
