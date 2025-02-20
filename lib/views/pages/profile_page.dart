import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout(AuthController model, context) async {
    try {
    await model.logout();
    Navigator.pop(context);
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          content: Text(
            error.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, model, __) {
        return Scaffold(
          body: Column(
            children: [
              const Spacer(),
              MainButton(
                onPressed: () {
                  logout(model, context);
                },
                text: 'Logout',
              )
            ],
          ),
        );
      },
    );
  }
}
