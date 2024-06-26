import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:todo_list/app/exception/auth_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('[register] | FirebaseAuthException |', error: e, stackTrace: s);
      if (e.code == 'email-already-in-use') {
        // final loginTypes =
        //     await _firebaseAuth.fetchSignInMethodsForEmail(email);
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

  @override
  Future<User?> login(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on PlatformException catch (e, s) {
      log('[login] | PlatformException |', error: e, stackTrace: s);
      throw AuthException(
        message: e.message ?? 'Erro ao realizar login.',
      );
    } on FirebaseAuthException catch (e, s) {
      log('[login] | FirebaseAuthException |', error: e, stackTrace: s);
      if (e.code == 'wrong-password') {
        throw AuthException(
          message: 'E-mail ou senha inválidos.',
        );
      }
      throw AuthException(
        message: e.message ?? 'Erro ao realizar login.',
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      var loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
          message: 'Cadastro com o Google, senha não pode ser resetada.',
        );
      } else {
        throw AuthException(
          message: 'E-mail não cadastrado.',
        );
      }
    } on PlatformException catch (e, s) {
      log('[forgotPassword] | PlatformException |', error: e, stackTrace: s);
      throw AuthException(
        message: 'Erro ao realizar recuperação de senha.',
      );
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
            message:
                'Você usou o e-mail para cadastro, caso tenha esquecido, clique no link de \'Esqueci a senha\'',
          );
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          );
          final userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      log('[googleLogin] | FirebaseAuthException |', error: e, stackTrace: s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
          message: '''
            Login inválido, você já se registrou com os seguintes provedores:
            ${loginMethods?.join(',')}
          ''',
        );
      } else {
        throw AuthException(
          message: 'Erro ao realizar login.',
        );
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
