import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:validatorless/validatorless.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      changeNotifier: context.read<LoginController>(),
    ).listener(
      context: context,
      everCallback: (notifier, listenerInstance) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      successCallback: (notifier, listenerInstance) {
        print('Login success');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const TodoListLogo(size: 150),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListField(
                              label: 'E-mail',
                              controller: _emailController,
                              focusNode: _emailFocus,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.required('E-mail obrigatório.'),
                                  Validatorless.email('E-mail inválido.'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            TodoListField(
                              label: 'Senha',
                              obscureText: true,
                              controller: _passwordController,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.required('Senha obrigatória.'),
                                  Validatorless.min(
                                    6,
                                    'Senha deve ter no mínimo 6 caracteres.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Esqueceu sua senha?'),
                                  onPressed: () {
                                    if (_emailController.text.isNotEmpty) {
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(
                                              _emailController.text);
                                    } else {
                                      _emailFocus.requestFocus();
                                      Messages.of(context).showError(
                                        'Digite e-mail para recuperar a senha.',
                                      );
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Login'),
                                  ),
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      context.read<LoginController>().login(
                                            email,
                                            password,
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfff0f3f7),
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            SignInButton(
                              Buttons.Google,
                              text: 'Continue com o Google',
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?'),
                                TextButton(
                                  child: const Text('Cadastre-se'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
