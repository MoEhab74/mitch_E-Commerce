import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_states.dart';
import 'package:minimal_e_commerce/helper/snack_bar_message.dart';
import 'package:minimal_e_commerce/pages/onboarding_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';

class UserAuthStatePage extends StatefulWidget {
  const UserAuthStatePage({super.key});

  @override
  State<UserAuthStatePage> createState() => _UserAuthStatePageState();
}

class _UserAuthStatePageState extends State<UserAuthStatePage> {
  @override
  void initState() {
    super.initState();
    // Check if the user is authenticated or not
    context.read<AuthCubit>().checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            showSnackBar(
              context,
              message: 'Welcome back ${state.user.firstName}',
            );
            Navigator.pushNamed(context, ShopPage.routeName);
          } else {
            Navigator.pushNamed(context, OnBoardingPage.routeName);
          }
        },
        builder: (context, state) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
