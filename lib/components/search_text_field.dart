import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        // Trigger search method here
        context.read<ShopCubit>().searchProduct(value);
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
      )
    );
  }
}
