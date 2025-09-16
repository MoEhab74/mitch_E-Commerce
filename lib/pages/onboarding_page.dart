import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/ny_buttom.dart';
import 'package:minimal_e_commerce/pages/login_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static const routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Icon(
                Icons.shopping_bag,
                size: 200,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              textAlign: TextAlign.center,
              'E-Commerce',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'High quality products, suitable for you',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 32),
            MyButtom(
              onTap: () => Navigator.pushNamed(context, LoginPage.routeName),
            )
          ],
        ),
      ),
    );
  }
}


