import 'package:ecommerce/utilities/router.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primaryColor: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: AppRoutes.authPageRoute,
    );
  }
}