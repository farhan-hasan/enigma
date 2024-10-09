import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SocialMediaIconButton extends StatelessWidget {
  const SocialMediaIconButton(
      {super.key, required this.iconSource, required this.onPressed});

  final String iconSource;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.05,
      width: context.height * 0.05,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).splashColor),
        borderRadius: BorderRadius.circular(context.height * 0.025),
      ),
      child: IconButton(
        style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor),
        onPressed: onPressed,
        icon: Image.asset(iconSource),
      ),
    );
  }
}
