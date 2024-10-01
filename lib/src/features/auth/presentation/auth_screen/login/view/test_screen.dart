import 'package:enigma/src/core/global/global_variables.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/auth/domain/entity/login_entity.dart';
import 'package:enigma/src/features/auth/presentation/auth_screen/login/view/login_screen.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  static const String route = "/test";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              container.read(goRouterProvider).go(LoginScreen.setRoute(
                  loginEntity: LoginEntity(id: 234, name: "Nayeem")));
            },
            child: Text("Go to Login")),
      ),
    );
  }
}
