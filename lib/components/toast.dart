import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastState{SUCCESS,ERROR,WARNING}

void showToast({
  required String message,
  required ToastState state,

}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: checkToastState(state),
    fontSize: 15,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    toastLength: Toast.LENGTH_SHORT,
  );
}

Color checkToastState(ToastState state){

  Color color ;

  switch(state){

    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow.shade400;
      break;
  }
  return color;

}

