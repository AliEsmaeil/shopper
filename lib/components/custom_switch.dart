import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {

  final bool value ;
  final Function(bool)? onChanged ;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,


  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: Switch(
        value: widget.value,
        onChanged: widget.onChanged,

        trackColor: MaterialStatePropertyAll( widget.value ? Colors.green: Colors.grey.shade500 ),

        thumbColor: MaterialStatePropertyAll(widget.value ? Colors.white: Colors.black),
        //trackOutlineColor:MaterialStatePropertyAll(Colors.grey.shade800) ,
        trackOutlineWidth: MaterialStatePropertyAll(0),


      ),
    );
  }
}
