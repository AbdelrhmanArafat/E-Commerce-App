import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  User? get currentUser;

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> registerWithEmailAndPassword(String email, String password);

  Future<void> logout();
}

class AuthServicesImplement implements AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }

  @override
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }
}
