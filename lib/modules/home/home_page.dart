import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/modules/categories_screen.dart';
import 'package:page_view/modules/favorites_screen.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/modules/home/cubit/states.dart';
import 'package:page_view/modules/products_screen.dart';
import 'package:page_view/modules/search/search_screen.dart';
import 'package:page_view/modules/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final body = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageCubit.getCubit(context);

          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Shopper',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                actions: [
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        MyNavigator.navigateTo(
                            screen: SearchScreen(), context: context);
                      }),
                  IconButton(
                    icon: Icon(
                      AppCubit.isDark ? Icons.light_mode : Icons.dark_mode,
                    ),
                    onPressed: () {
                      AppCubit.getCubit(context).changeThemeMode();
                    },
                  ),
                ],
              ),
              drawer: const MyDrawer(),
              body: body[cubit.currentIndex],
              bottomNavigationBar: NavigationBar(
                destinations: const <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.category_outlined),
                    selectedIcon: Icon(Icons.category),
                    label: 'Categories',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                onDestinationSelected: (index) {
                  cubit.changeNavigationDestination(index);
                },
                selectedIndex: cubit.currentIndex,
              ),
            ),
          );
        });
  }
}
