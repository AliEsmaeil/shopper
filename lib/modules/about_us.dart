import 'package:flutter/material.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/cubit/cubit.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<String> titles = [
    ' 1. Establish a mission statement',
    ' 2. Outline your company story'
  ];
  final List<String> bodies = [
    'However, to draw people in, you need to succinctly state your goal in the industry up front. What is your business here to do? Why should your website visitors care? ',
    'This information will give the reader something to remember about your company long after they leave your website.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                AppCubit.isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                AppCubit.getCubit(context).changeThemeMode();
              },
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: titles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            titles[index],
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(bodies[index]),
        ),
      ),
    );
  }
}

/*
Text(''' ''')
 */
