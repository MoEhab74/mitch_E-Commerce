import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/categories_cubit/categories_cubit.dart';
import 'package:minimal_e_commerce/cubits/categories_cubit/categories_state.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  int selectedIndex = 0;
  List<String>? categories;
  @override
  void initState() {
    super.initState();
    // Get all the categories from the API
    _loadCategories();
    log('Categories list fitched from the API successfully');
  }

  Future<void> _loadCategories() async {
    await context.read<CategoriesCubit>().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesError) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Error: ${state.errorMessage.length > 50 ? {'${state.errorMessage.substring(0, 30)} ....'} : state.errorMessage}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            );
          }
          categories = state.categories;
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: selectedIndex == index
                          ? [BoxShadow(color: Colors.black12, blurRadius: 5)]
                          : [],
                    ),
                    child: Text(
                      categories![index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: selectedIndex == index ? 16 : 14,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
            itemCount: categories!.length,
          );
        },
      ),
    );
  }
}
