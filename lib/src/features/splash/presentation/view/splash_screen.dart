import 'dart:async';

import 'package:enigma/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/auth/presentation/auth_screen/view/auth_screen.dart';
import 'package:enigma/src/features/message/domain/entity/message_entity.dart';
import 'package:enigma/src/features/message/presentation/view/message_screen.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const route = '/splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final SharedPreferenceManager sharedPreferenceManager =
      sl.get<SharedPreferenceManager>();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        bool isLogged = sharedPreferenceManager.getValue(
                key: SharedPreferenceKeys.AUTH_STATE) ??
            false;
        if (!isLogged) {
          ref.read(goRouterProvider).go(AuthScreen.setRoute());
        } else {
          ref.read(goRouterProvider).go(
                MessageScreen.setRoute(
                  messageEntity: MessageEntity(),
                ),
              );
        }
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
