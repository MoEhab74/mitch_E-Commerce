import 'package:flutter/material.dart';

class MyButtom extends StatelessWidget {
  const MyButtom({
    super.key, this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16),),
        padding: const EdgeInsets.all(16),
        child: Icon(Icons.arrow_forward, size: 32, color: Theme.of(context).colorScheme.surface,),
      ),
    );
  }
}