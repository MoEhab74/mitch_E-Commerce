import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_states.dart';
import 'package:minimal_e_commerce/pages/onboarding_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';

class UserAuthStatePage extends StatefulWidget {
  const UserAuthStatePage({super.key});

  @override
  State<UserAuthStatePage> createState() => _UserAuthStatePageState();
}

class _UserAuthStatePageState extends State<UserAuthStatePage> {
  bool? isUserLoggedIn;
  @override
  void initState() {
    super.initState();
    // Check if the user is authenticated or not
    context.read<AuthCubit>().checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccess) {
          log('Welcome back!');
          return const ShopPage();
        } else if (state is AuthInitial) {
          log('Logged out!');
          return const OnBoardingPage();
        } else {
          return const Center(child: Text("Unexpected state"));
        }
      },
    );
  }
}
