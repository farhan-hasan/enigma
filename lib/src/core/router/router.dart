import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:enigma/src/features/auth/presentation/login/view/test_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: SplashScreen.route,
      observers: [BotToastNavigatorObserver()],
      routes: [
        GoRoute(
          path: LoginScreen.route,
          builder: (context, state) {
            return LoginScreen(
              data: state.pathParameters,
            );
          },
        ),
        GoRoute(
          path: SplashScreen.route,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: AuthScreen.route,
          builder: (context, state) {
            return const AuthScreen();
          },
        ),
      ],
    );
  },
);
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
