import 'package:flutter/material.dart';

class SharedAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppbar(
      {super.key,
      required this.title,
      required this.leadingWidget,
      required this.trailingWidgets});

  final String title;
  final List<Widget> trailingWidgets;
  final Widget leadingWidget;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      leading: Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(10),
          child: leadingWidget),
      actions: trailingWidgets,
    );
  }
}
