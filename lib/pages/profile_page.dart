import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/profile_item.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/helper/show_hint_dialog.dart';
import 'package:minimal_e_commerce/models/user_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String routeName = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = context.read<AuthCubit>().getCurrentUser()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              Center(
                child: ClipOval(
                  child: Image.network(
                    currentUser.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${currentUser.firstName} ${currentUser.lastName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Lora',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentUser.email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Lora',
                ),
              ),
              const SizedBox(height: 32),
              ProfileItem(text: currentUser.username, icon: Icons.person),
              const SizedBox(height: 12),
              ProfileItem(
                text: currentUser.gender!,
                icon: currentUser.gender == 'male' ? Icons.male : Icons.female,
              ),
              const SizedBox(height: 12),
              ProfileItem(
                text: 'Logout',
                icon: Icons.logout_outlined,
                onTap: () {
                  showHintDialog(
                    context,
                    title: 'Log out',
                    content: 'Are you sure you want to logout?',
                    buttonText: 'log out',
                    onPressedAction: () {
                      // Trigger the logout from the AuthCubit
                      context.read<AuthCubit>().logoutUser(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
