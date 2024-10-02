import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.buttonName, required this.onPressed});

  final String buttonName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.8,
      height: context.height * 0.07,
      child: ElevatedButton(
        onPressed: onPressed,
        // style: ElevatedButton.styleFrom(
        //   minimumSize: Size(context.width * 0.8, context.width * 0.15),
        // ),
        child: Text(
          buttonName,
          //style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
