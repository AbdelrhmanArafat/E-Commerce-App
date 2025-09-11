import 'package:ecommerce/controllers/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/utilities/assets.dart';
import 'package:ecommerce/utilities/enums.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:ecommerce/views/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 60.0,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authCubit.authFromType == AuthFormType.login
                        ? 'Login'
                        : 'Register',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 80.0),
                  //Email
                  TextFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter your Email' : null,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Your Email!',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  //Password
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter your Password' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Your Password!',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  //Forget password on login
                  if (authCubit.authFromType == AuthFormType.login)
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {},
                        child: const Text('Forgot Your Password?'),
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  BlocConsumer<AuthCubit, AuthState>(
                      bloc: authCubit,
                      listenWhen: (previous, current) =>
                          current is AuthSuccess ||
                          current is AuthFailure ||
                          current is AuthSuccess,
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          MainDialog(
                            context: context,
                            title: 'Error',
                            content: state.message,
                          ).showAlertDialog();
                        } else if (state is AuthSuccess) {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.bottomNavBarPageRoute
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AuthLoading ||
                          current is AuthSuccess ||
                          current is AuthFailure ||
                          current is AuthInitial,
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return MainButton(
                            child: const CircularProgressIndicator.adaptive(),
                          );
                        }
                        return MainButton(
                          text: authCubit.authFromType == AuthFormType.login
                              ? 'Login'
                              : 'Register',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              authCubit.authFromType == AuthFormType.login
                                  ? await authCubit.login(emailController.text,
                                      passwordController.text)
                                  : await authCubit.signUp(emailController.text,
                                      passwordController.text);
                            }
                          },
                        );
                      }),
                  const SizedBox(height: 16.0),
                  //toggle between login and register
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        formKey.currentState!.reset();
                        authCubit.toggleFromType();
                      },
                      child: Text(
                        authCubit.authFromType == AuthFormType.login
                            ? 'Don\'t Have an Account? Register'
                            : 'Already Have an Account? Login',
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .09),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      authCubit.authFromType == AuthFormType.login
                          ? 'Or Login With'
                          : 'Or Register With',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        iconName: AppAssets.googleIcon,
                        onTap: () {},
                      ),
                      const SizedBox(width: 16.0),
                      SocialMediaButton(
                        iconName: AppAssets.facebookIcon,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
