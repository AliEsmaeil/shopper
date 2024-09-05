import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


sealed class Themes{

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 24,
        fontFamily: 'Mono',
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Mono',
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontFamily: 'Mono',
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontFamily: 'Mono',
      ),

    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 18,
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
        size: 18,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      prefixIconColor: Colors.black,
      suffixIconColor: Colors.black,

      contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 1,color: Colors.grey.shade100),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1,color: Colors.blue.shade600),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1,color: Colors.red),
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1,color: Colors.red.shade500),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blue.shade300),
          elevation: WidgetStatePropertyAll(1),
          //overlayColor: WidgetStatePropertyAll(Colors.white38),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          minimumSize: WidgetStatePropertyAll(const Size(double.infinity, 45)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.blue.shade800,),
          //textStyle:

        )
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      iconTheme: WidgetStatePropertyAll(const IconThemeData(
        color: Colors.black,
        size: 20,
      ),),
      elevation: 0,
      height: 70,
      indicatorColor: Colors.blue.shade100,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.blue.shade700,
      linearMinHeight: 1,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.white,
      margin: const EdgeInsetsDirectional.only(start: 5,top: 5,bottom: 5),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 24,
        fontFamily: 'Mono',
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Mono',
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontFamily: 'Mono',
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontFamily: 'Mono',
      ),

    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        size: 18,
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade600,

      prefixIconColor: Colors.grey.shade400,
      suffixIconColor: Colors.grey.shade400,

      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 1,color: Colors.grey.shade600),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1,color: Colors.grey.shade300),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 1,color: Colors.red.shade700),
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1,color: Colors.red.shade500),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          elevation: WidgetStatePropertyAll(1),
          //overlayColor: WidgetStatePropertyAll(Colors.white38),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 45)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.blue,),
        //textStyle:

      ),

    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: WidgetStatePropertyAll(IconThemeData(
        color: Colors.white,
        size: 18,
      ),),
      height: 70,
      indicatorColor: Colors.blue.shade100,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.blue.shade700,
      linearMinHeight: 1,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20,
    ),

    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.black,
      shadowColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.black,
      margin: EdgeInsetsDirectional.only(start: 5,top: 5,bottom: 5),
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
    ),
  );

}