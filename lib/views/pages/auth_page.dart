import 'package:ecommerce/utilities/enums.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var authType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 60.0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authType == AuthFormType.login ? 'login' : 'register',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 80.0),
                TextFormField(
                  controller: emailController,
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
                TextFormField(
                  controller: passwordController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please Enter your Password' : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Your Password!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (authType == AuthFormType.login)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Text('Forgot Your Password?'),
                    ),
                  ),
                const SizedBox(height: 24.0),
                MainButton(
                  onPressed: () {},
                  text: authType == AuthFormType.login ? 'Login' : 'Register',
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (authType == AuthFormType.login) {
                          authType = AuthFormType.register;
                        } else {
                          authType = AuthFormType.login;
                        }
                      });
                    },
                    child: Text(
                      authType == AuthFormType.login
                          ? 'Don\'t Have an Account? Register'
                          : 'Already Have an Account? Login',
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  authType == AuthFormType.login
                      ? 'Or Login With'
                      : 'Or Register With',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      //todo: add google icon
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      //todo: add facebook icon
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
