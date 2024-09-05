import 'package:flutter/material.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/home/home_page.dart';
import 'package:page_view/modules/intro/page_view.dart';
import 'package:page_view/modules/login/login_screen.dart';

final class StartHandler {
  static bool? firstRun;
  static String? token;
  static Widget? widget;

  // initiating members

  static void initiatingMembers() {
    firstRun =
        SharedPrefHelper.readData(key: SharedPreferenceConstants.isFirstRun);
    token = SharedPrefHelper.readData(key: SharedPreferenceConstants.token);
    widget = getStartScreen();
  }

  static Widget getStartScreen() {
    if (firstRun == null) {
      widget = PageViewScreen();
    } else {
      if (firstRun!) {
        widget = PageView();
      } else {
        widget = (token == null) ? LoginScreen() : HomeScreen();

      }
    }

    return widget!;
  }
}
