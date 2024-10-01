import 'dart:convert';

import 'package:enigma/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/features/auth/domain/entity/login_entity.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required this.data}) {
    loginEntity = LoginEntity.fromJson(jsonDecode(data["login_entity"]));
  }
  Map<String, dynamic> data;
  LoginEntity? loginEntity;
  static const route = "/login/:login_entity";
  static setRoute({required LoginEntity loginEntity}) =>
      "/login/${jsonEncode(loginEntity.toJson())}";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SharedPreferenceManager preferenceManager = sl.get();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t) {
      preferenceManager.insertValue<int>(
          key: SharedPreferenceKeys.CHECK_KEY, data: 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  preferenceManager.getValue<int>(
                      key: SharedPreferenceKeys.CHECK_KEY);
                },
                child: const Text("Check")),
            Text("${widget.loginEntity?.id} - ${widget.loginEntity?.name}")
          ],
        ),
      ),
    );
  }
}
