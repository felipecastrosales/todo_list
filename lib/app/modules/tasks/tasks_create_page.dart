import 'package:flutter/material.dart';

import 'package:validatorless/validatorless.dart';

import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'tasks_create_controller.dart';
import 'widgets/calendar_button.dart';

class TasksCreatePage extends StatefulWidget {
  final TasksCreateController _controller;

  const TasksCreatePage({
    super.key,
    required TasksCreateController controller,
  }) : _controller = controller;

  @override
  State<TasksCreatePage> createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  dispose() {
    super.dispose();
    _descriptionTextEditingController.dispose();
  }

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
        key: _formKey,
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
              TodoListField(
                label: '',
                controller: _descriptionTextEditingController,
                validator: Validatorless.required('Descrição obrigatória'),
              ),
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
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            widget._controller.save(_descriptionTextEditingController.text);
          }
        },
      ),
    );
  }
}
