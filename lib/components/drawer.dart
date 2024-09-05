import 'package:flutter/material.dart';
import 'package:page_view/components/account_header.dart';
import 'package:page_view/components/list_tile.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/modules/about_us.dart';
import 'package:page_view/modules/account/account_screen.dart';
import 'package:page_view/modules/faqs/faqs_screen.dart';
import 'package:page_view/modules/home/home_page.dart';
import 'package:page_view/modules/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: AccountHeader(
                radius : 32,),
          ),

          CustomListTile(
            listTitle: const Text('Home'),
            preIcon: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
              MyNavigator.navigateTo(screen: HomeScreen(), context: context);
            },
          ),
          CustomListTile(
            listTitle: const Text('Account'),
            preIcon: const Icon(Icons.account_circle_rounded),
            onTap: () {
              Navigator.of(context).pop();
              MyNavigator.navigateTo(screen: AccountScreen(), context: context);
            },
          ),
          CustomListTile(
            listTitle: const Text('Settings'),
            preIcon: const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
               MyNavigator.navigateTo(screen: const SettingsScreen(), context: context);
            },
          ),
          CustomListTile(
            listTitle: const Text('FAQs'),
            preIcon: const Icon(Icons.question_mark_outlined),
            onTap: () {
              Navigator.of(context).pop();
              MyNavigator.navigateTo(screen: const FaqsScreen(), context: context);
            },
          ),
          CustomListTile(
            listTitle: const Text('About us'),
            preIcon: const Icon(Icons.comment),
            onTap: () {
              Navigator.of(context).pop();
              MyNavigator.navigateTo(screen: AboutUsScreen(), context: context);
            },
          ),
          CustomListTile(
            listTitle: const Text('Log Out'),
            preIcon: const Icon(Icons.logout_outlined),
            onTap: () {
              MyNavigator.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
