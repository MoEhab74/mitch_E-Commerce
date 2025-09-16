import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/app_button.dart';
import 'package:minimal_e_commerce/components/my_text_form_field.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/helper/snack_bar_message.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // userName textFormField
                  MyTextFormField(labelText: 'User name', icon: Icons.person),

                  // Password textFormField
                  MyTextFormField(
                    labelText: 'Password',
                    icon: Icons.visibility_off,
                    obscureText: true,
                  ),

                  // Login button
                  AppButton(
                    title: 'Login',
                    snackBarMessage: 'Logged in successfully',
                    onPressed: () {
                      // Trigger cubit method
                      // context.read<AuthCubit>().loginUser();
                      // show snackbar
                      showSnackBar(context,
                          message: 'Logged in successfully');
                    },
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
