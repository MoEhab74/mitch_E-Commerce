import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key, this.onTap, this.icon, required this.title,
  });
  final VoidCallback? onTap;
  final IconData? icon;
  final String title;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onTap:onTap
      ),
    );
  }
}