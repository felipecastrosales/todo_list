import 'package:flutter/material.dart';

import 'package:todo_list/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  TodoListField({
    super.key,
    this.controller,
    this.validator,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.focusNode,
  })  : assert(
          obscureText == true ? suffixIconButton == null : true,
          'Obscure Text não pode ser enviado junto com suffixIconButton',
        ),
        obscureTextVN = ValueNotifier(obscureText);

  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        color: Colors.black,
                        onPressed: () {
                          obscureTextVN.value = !obscureTextVN.value;
                        },
                        icon: Icon(
                          !obscureTextValue
                              ? TodoListIcons.eye
                              : TodoListIcons.eye_slash,
                          size: 15,
                        ),
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
