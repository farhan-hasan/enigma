import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.buttonName, required this.onPressed});

  final String buttonName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size(context.width * 0.8, context.width * 0.15),
      ),
      child: Text(
        buttonName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
