import 'package:flutter/material.dart';

Future<dynamic> getDialog(context)=>
    showDialog(
    context: context,
    builder: (context)=>AlertDialog(
      title: const Text('Confirmation'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      surfaceTintColor: Colors.white,
      contentPadding: const EdgeInsets.all(8),
      titlePadding: const EdgeInsets.all(8),
      icon: Icon(Icons.crisis_alert,color: Colors.red.shade700,),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      content: const Text('Are you sure about permanent delete of your account'),
      actionsPadding: const EdgeInsets.all(8),

      actions: [
        TextButton(
          child: const Text('No'),
          onPressed: (){
            return Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: (){

            return Navigator.of(context).pop(true);
          },
        ),
      ],
    )
);
