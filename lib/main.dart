import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utilities/router.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.landingPageRoute,
      ),
    );
  }
}
