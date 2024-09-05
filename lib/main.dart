import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/core/themes/themes.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/cubit/states.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/network/remote/dio_helper.dart';
import 'package:page_view/utils/bloc_observer.dart';
import 'package:page_view/utils/start_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefHelper().initiatePrefs();
  DioHelper();
  StartHandler.initiatingMembers();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => HomePageCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppChangedThemeState) {
            setSystemChrome();
          }
        },
        builder: (context, state) {
          return MaterialApp(
            home: Directionality(
              textDirection: AppCubit.isDirectionalityLTR
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: StartHandler.widget!,
            ),
            debugShowCheckedModeBanner: false,
            title: 'Shopping App',
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: AppCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            themeAnimationDuration: Duration(seconds: 3),
            themeAnimationCurve: Curves.easeOut,
          );
        },
      ),
    );
  }

  void setSystemChrome() {
    bool? isDark =
        SharedPrefHelper.readData(key: SharedPreferenceConstants.isDark);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark == null
          ? Colors.white
          : isDark
              ? Colors.black
              : Colors.white,
      statusBarIconBrightness: isDark == null
          ? Brightness.dark
          : isDark
              ? Brightness.light
              : Brightness.dark,
    ));
  }
}
