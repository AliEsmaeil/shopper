import 'package:flutter/material.dart';
import 'package:page_view/components/custom_switch.dart';
import 'package:page_view/components/list_tile.dart';
import 'package:page_view/cubit/cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool themeValue = AppCubit.isDark;
  bool languageValue = AppCubit.isDirectionalityLTR;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.getCubit(context);

    return ListView(
      children: [
        CustomListTile(
          listTitle: const Text('Theme mode'),
          listSubTitle: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Text(themeValue ? 'dark mode' : 'light mode'),
          ),
          preIcon: themeValue
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
          onTap: () {
            setState(() {
              themeValue = !themeValue;
            });
            cubit.changeThemeMode();
          },
          sufIcon: CustomSwitch(
              value: themeValue,
              onChanged: (v) {
                setState(() {
                  themeValue = !themeValue;
                });
                cubit.changeThemeMode();
              }),
        ),
        const Divider(
          height: 0,
          thickness: .5,
          indent: 50,
        ),
        CustomListTile(
          listTitle: const Text('Language'),
          listSubTitle: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Text(languageValue ? 'english' : 'arabic'),
          ),
          preIcon: languageValue
              ? const Icon(Icons.abc)
              : const Icon(Icons.language),
          onTap: () {
            setState(() {
              languageValue = !languageValue;
            });
            cubit.changeDirectionality(context);
          },
          sufIcon: CustomSwitch(
              value: languageValue,
              onChanged: (v) {
                setState(() {
                  languageValue = !languageValue;
                });
                cubit.changeDirectionality(context);
              }),
        ),
        const Divider(
          height: 0,
          thickness: .5,
          indent: 50,
        )
      ],
    );
  }
}
