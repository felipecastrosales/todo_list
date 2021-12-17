import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                        child: Column(
                          children: [
                            TodoListField(
                              label: 'E-mail',
                            ),
                            const SizedBox(height: 20),
                            TodoListField(
                              label: 'Senha',
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Esqueceu sua senha?'),
                                  onPressed: () {},
                                ),
                                ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Login'),
                                  ),
                                  onPressed: () {},
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
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                          color: const Color(0xfff0f3f7),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
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
