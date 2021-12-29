import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list/app/models/task_model.dart';

abstract class UserService {
  Future<User?> register(
    String email,
    String password,
  );
  Future<User?> login(
    String email,
    String password,
  );
  Future<void> forgotPassword(String email);
  Future<User?> googleLogin();
  Future<void> logout();
  Future<void> updateDisplayName(String name);
}
