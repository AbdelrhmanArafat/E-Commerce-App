import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFromType;

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFromType = AuthFormType.login,
  });

  Future<void> submit() async {
    try {
      if (authFromType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.registerWithEmailAndPassword(email, password);
      }
    } catch (error) {
      rethrow;
    }
  }

  void toggleFromType() {
    final formType = authFromType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFromType: formType,
    );
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFromType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFromType = authFromType ?? this.authFromType;
    notifyListeners();
  }
}
