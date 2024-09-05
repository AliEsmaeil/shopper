import 'package:flutter/material.dart';

class CustomListTile extends ListTile {
  const CustomListTile(
      {super.key,
      this.listTitle,
      this.listSubTitle,
      this.onTap,
      this.preIcon,
      this.sufIcon,});

  final Widget? listTitle;
  final Widget? listSubTitle;
  final Widget? preIcon;
  final Widget? sufIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
         // onTap: onTap,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'TimesNewRoman',
          ),
          leading: preIcon,
          title: listTitle,

          subtitle: listSubTitle,
          trailing: sufIcon,
        ),
      ),
    );
  }
}
