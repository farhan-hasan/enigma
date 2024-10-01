import 'package:flutter/material.dart';

Widget socialMediaButton(String iconSource, Function() onPressed) {
  return Container(
    decoration: BoxDecoration(),
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(iconSource),
    ),
  );
}
