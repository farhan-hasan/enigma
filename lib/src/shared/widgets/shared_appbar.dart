import 'package:flutter/material.dart';

class SharedAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppbar(
      {super.key,
      required this.title,
      this.leadingWidget,
      this.trailingWidgets});

  final String title;
  final List<Widget>? trailingWidgets;
  final Widget? leadingWidget;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(title),
      leading: leadingWidget ?? null,
      actions: trailingWidgets ?? null,
    );
  }
}
