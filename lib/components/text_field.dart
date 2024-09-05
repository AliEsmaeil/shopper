import 'package:flutter/material.dart';

Widget defaultTextField({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction? textInputAction = TextInputAction.next,
  bool isPassword = false,
  Function(String?)? onSubmitted,
  required String?Function(String?) validator,
  required BuildContext context,
  required String label ,
  required IconData preIcon,
  bool autoFocus = false,
  IconData? sufIcon,
  VoidCallback? sufPressed,
  Function(String)? onChanged,

})=>TextFormField(

  controller: controller,
  keyboardType: keyboardType,
  textInputAction: textInputAction,
  autofocus: autoFocus,
  maxLines: 1,
  obscureText: isPassword,
  cursorColor: Colors.blue.shade700,
  cursorWidth: 1,
  onFieldSubmitted: onSubmitted ,
  onChanged: onChanged,
  validator: validator,
  decoration: InputDecoration(
    labelText: label,
    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontFamily: 'Times New Roman',
      fontSize: 12,
    ),
    prefixIcon: Icon(preIcon,size: 18,),
    suffixIcon: IconButton(
      icon: Icon(sufIcon ,size: 18,color: Colors.grey.shade700,),
      onPressed: sufPressed,
    ),

  )

);