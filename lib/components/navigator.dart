import 'package:flutter/material.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/login/login_screen.dart';


// already named routes is easy to use, but this project's screen number is not a big one,
class MyNavigator{

  static void navigateTo({required Widget screen ,required BuildContext context,}){

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => screen,
      ),
    );
  }

  static void navigateAndRemove({required Widget screen ,required BuildContext context,}){

    Navigator.of(context).pushAndRemoveUntil(

        MaterialPageRoute(builder: (context)=>screen),
          (route) => false);
  }

  static void signOut(BuildContext context){

    SharedPrefHelper.removeData(
        key: SharedPreferenceConstants.token)
        .then((value) {
      if (value) {
        navigateAndRemove(
            screen: LoginScreen(), context: context);
      }
    }).catchError((error) {
      debugPrint('error in signing out');
    });

  }

}