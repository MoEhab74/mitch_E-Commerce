import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/app_button.dart';
import 'package:minimal_e_commerce/components/my_text_form_field.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_states.dart';
import 'package:minimal_e_commerce/helper/snack_bar_message.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextFormField(
            controller: _usernameController,
            labelText: 'User name',
            icon: Icons.person,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'User name is required'
                : null,
          ),
          MyTextFormField(
            controller: _passwordController,
            labelText: 'Password',
            icon: Icons.lock,
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                // Close the keyboard
                FocusScope.of(context).unfocus();
                showSnackBar(
                  context,
                  message: 'Welcome ${state.user.username}',
                );
                // Navigate to the home page
                Navigator.of(context).pushNamed(ShopPage.routeName);
              } else if (state is AuthError) {
                showSnackBar(context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const AppButton(title: 'Loading...', onPressed: null);
              }
              return AppButton(
                title: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().loginUser(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
