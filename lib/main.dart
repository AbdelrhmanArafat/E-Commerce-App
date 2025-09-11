import 'package:ecommerce/controllers/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:ecommerce/utilities/router.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  await initSetup();
  runApp(const MyApp());
}

Future<void> initSetup() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = AppConstants.publishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.authStates();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: BlocProvider.of<AuthCubit>(context),
            buildWhen: (previous, current) =>
                current is AuthInitial || current is AuthSuccess,
            builder: (context, state) {
              return MaterialApp(
                title: 'E-commerce App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: const Color(0xFFF9F9F9),
                  primaryColor: Colors.red,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    elevation: 2,
                  ),
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
                initialRoute: state is AuthSuccess
                    ? AppRoutes.bottomNavBarPageRoute
                    : AppRoutes.authPageRoute,
              );
            },
          );
        }
      ),
    );
  }
}
