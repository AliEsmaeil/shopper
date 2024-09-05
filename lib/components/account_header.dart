import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';

class AccountHeader extends StatelessWidget {
  final double radius;
  const AccountHeader({super.key, this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey,
          //Note: the api provide a malfunctioning image, let's use user image from shared prefs
          backgroundImage: SharedPrefHelper.readData(
                      key: SharedPreferenceConstants.userImage) !=
                  null
              ? FileImage(File(SharedPrefHelper.readData(
                  key: SharedPreferenceConstants.userImage)))
              : null,
        ),
        Expanded(
          child: ListTile(
            title: Text(SharedPrefHelper.readData(
                        key: SharedPreferenceConstants.userData) !=
                    null
                ? SharedPrefHelper.readData(
                    key: SharedPreferenceConstants.userData)[0]
                : ''),
            subtitle: Text(
              SharedPrefHelper.readData(
                          key: SharedPreferenceConstants.userData) !=
                      null
                  ? SharedPrefHelper.readData(
                      key: SharedPreferenceConstants.userData)[1]
                  : '',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
