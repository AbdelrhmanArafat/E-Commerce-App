import 'package:ecommerce/controllers/cubits/auth/auth_cubit.dart';
import 'package:ecommerce/utilities/routes.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return SafeArea(
      child: Column(
        children: [
          BlocConsumer<AuthCubit, AuthState>(
            bloc: authCubit,
            listenWhen: (previous, current) {
              return current is AuthSuccess || current is AuthInitial;
            },
            listener: (context, state) {
              if (state is AuthFailure) {
                MainDialog(
                  context: context,
                  title: 'Error',
                  content: state.message,
                ).showAlertDialog();
              } else if (state is AuthInitial) {
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                  AppRoutes.authPageRoute,
                );
              }
            },
            buildWhen: (previous, current) {
              return current is AuthInitial ||
                  current is AuthLoading ||
                  current is AuthFailure;
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return MainButton(
                  child: const CircularProgressIndicator.adaptive(),
                );
              }
              return MainButton(
                onPressed: () async {
                  await authCubit.logout();
                },
                text: 'Logout',
              );
            },
          )
        ],
      ),
    );
  }
}
