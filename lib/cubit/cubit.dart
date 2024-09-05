import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/cubit/states.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';

class AppCubit extends Cubit<AppStates> {
  static bool isDark = false;
  static bool isDirectionalityLTR = true;

  AppCubit() : super(AppInitialState()) {
    isDark = SharedPrefHelper.readData(key: SharedPreferenceConstants.isDark) ??
        false;
    isDirectionalityLTR = SharedPrefHelper.readData(
            key: SharedPreferenceConstants.directionality) ??
        true;
  }

  static AppCubit getCubit(BuildContext context) => BlocProvider.of(context);

  void changeThemeMode() {
    isDark = !isDark;
    SharedPrefHelper.writeData(
        key: SharedPreferenceConstants.isDark, value: isDark);

    emit(AppChangedThemeState());
  }

  void changeDirectionality(context) {
    isDirectionalityLTR = !isDirectionalityLTR;
    SharedPrefHelper.writeData(
        key: SharedPreferenceConstants.directionality,
        value: isDirectionalityLTR);

    var cubit = HomePageCubit.getCubit(context);

    cubit.getHomeData();
    cubit.getCategories();

    emit(AppChangedDirectionalityState());
  }
}
