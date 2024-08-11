import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/validators/validators.dart';
import 'package:todo_list/app/core/widgets/todo_list_button.dart';
import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';

import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
      changeNotifier: context.read<RegisterController>(),
    );
    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        // Navigator.of(context).pop(); removed by change in AuthProvider
      },
      // optional
      // errorCallback: (
      //   notifier,
      //   listenerInstance,
      // ) {
      //   listenerInstance.dispose();
      // },
    );
    // context.read<RegisterController>().addListener(() {
    //   final controller = context.read<RegisterController>();
    //   var success = controller.success;
    //   var error = controller.error;
    //   if (success == true) {
    //     Navigator.of(context).pop();
    //   } else if (error != null && error.isNotEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(error),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   }
    // });
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 15,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: TodoListLogo(
              size: 120,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'E-mail',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail obrigatório.'),
                        Validatorless.email('E-mail inválido.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TodoListField.fromPassword(
                    controller: _passwordController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatória.'),
                        Validatorless.min(
                          6,
                          'Senha deve ter pelo menos 6 caracteres.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TodoListField.fromPassword(
                    label: 'Confirmar Senha',
                    controller: _confirmPasswordController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Confirmar senha obrigatória.'),
                        Validators.compare(
                          _confirmPasswordController,
                          'As senhas não são iguais.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TodoListButton(
                      title: 'Salvar',
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          context.read<RegisterController>().registerUser(
                                email,
                                password,
                              );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
