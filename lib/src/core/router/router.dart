import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
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
            return LoginScreen();
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
  return GoRouter(
      initialLocation: MessageScreen.setRoute(
          messageEntity: MessageEntity(id: 1, message: "hello")),
      observers: [
        BotToastNavigatorObserver()
      ],
      routes: [
        GoRoute(
            path: LoginScreen.route,
            builder: (context, state) {
              return LoginScreen();
            }),
        StatefulShellRoute.indexedStack(
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                    path: MessageScreen.route,
                    builder: (context, state) {
                      return MessageScreen(
                        data: state.pathParameters,
                      );
                    }),
              ])
            ],
            builder: (context, state, navigationShell) {
              return BottomNavScreen(navigationShell: navigationShell);
            })
      ]);
});
