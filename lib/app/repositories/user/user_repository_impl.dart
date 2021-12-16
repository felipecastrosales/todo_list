import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list/app/exception/auth_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
            message: 'E-mail já utilizado, por favor escolha outro e-mail.',
          );
        } else {
          throw AuthException(
            message: 'Você já se cadastrou no TodoList, utilize sua conta.',
          );
        }
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao registrar usuário.',
        );
      }
    }
  }
}
