import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const AuthPage(),
            );
          }
          return const BottomNavBarPage();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
