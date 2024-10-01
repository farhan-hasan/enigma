import 'dart:async';

import 'package:enigma/src/core/global/global_variables.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/auth/presentation/auth_screen/view/auth_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const route = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        container.read(goRouterProvider).go(AuthScreen.setRoute());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "E",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Enigma",
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
