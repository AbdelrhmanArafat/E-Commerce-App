import 'package:bloc/bloc.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/utilities/enums.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImplement();
  var authFromType = AuthFormType.login;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.loginWithEmailAndPassword(email, password);

      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Incorrect Credentials'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.registerWithEmailAndPassword(email, password);

      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Incorrect Credentials'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authServices.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void authStates() {
    final user = authServices.currentUser;
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  void toggleFromType() {
    final formType = authFromType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    emit(ToggleFormType(formType));
  }
}
