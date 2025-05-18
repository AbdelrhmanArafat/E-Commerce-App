import 'package:ecommerce/controllers/database_controller.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:ecommerce/utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFromType;
  final database = FireStoreDatabase('123');

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFromType = AuthFormType.login,
  });

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> submit() async {
    try {
      if (authFromType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        final user = await auth.registerWithEmailAndPassword(email, password);
        await database.getUserData(
          UserModel(
            uid: user?.uid ?? documentIdFromLocalData(),
            email: email,
          ),
        );
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
