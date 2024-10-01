import 'package:enigma/src/core/styles/theme/enigma_theme.dart';
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
      backgroundColor: customDarkTheme.canvasColor,
      foregroundColor: customDarkTheme.focusColor,
      centerTitle: true,
      title: Text(title),
      leading: leadingWidget,
      actions: trailingWidgets,
    );
  }
}
