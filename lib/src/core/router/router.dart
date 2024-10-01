import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(initialLocation: LoginScreen.route, observers: [
    BotToastNavigatorObserver()
  ], routes: [
    GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return LoginScreen();
        }),
  ]);
});
