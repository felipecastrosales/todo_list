import 'package:flutter/material.dart';

import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/services/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;
  bool loading = false;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(
    String email,
    String password,
  ) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(
        email,
        password,
      );
      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar usuário.';
      }
      notifyListeners();
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
