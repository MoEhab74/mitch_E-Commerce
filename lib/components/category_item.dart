import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/constants.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // Filter products by category ===> trigger the method from ShopCubit
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Chip(
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: selectedIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                label: Text(categories[index]),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedIndex == index
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox();
        },
        itemCount: categories.length,
      ),
    );
  }
}
