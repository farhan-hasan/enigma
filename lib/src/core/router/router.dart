import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/features/auth/presentation/auth_screen/login/view/login_screen.dart';
import 'package:enigma/src/features/auth/presentation/auth_screen/view/auth_screen.dart';
import 'package:enigma/src/features/message/domain/entity/message_entity.dart';
import 'package:enigma/src/features/message/presentation/view/message_screen.dart';
import 'package:enigma/src/features/splash/presentation/view/splash_screen.dart';
import 'package:enigma/src/shared/view/bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: MessageScreen.setRoute(
          messageEntity: MessageEntity(id: 1, message: "Message Screen")),
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
        StatefulShellRoute.indexedStack(
            branches: [
              StatefulShellBranch(
                  initialLocation: MessageScreen.setRoute(
                      messageEntity:
                          MessageEntity(id: 1, message: "Message Screen")),
                  routes: [
                    GoRoute(
                        path: MessageScreen.route,
                        builder: (context, state) {
                          return MessageScreen(
                            data: state.pathParameters,
                          );
                        }),
                  ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: "/calls",
                    builder: (context, state) {
                      return Center(child: Text("This is calls screen"));
                    }),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: "/contacts",
                    builder: (context, state) {
                      return Center(child: Text("This is contacts screen"));
                    }),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: "/settings",
                    builder: (context, state) {
                      return Center(child: Text("This is settings screen"));
                    }),
              ])
            ],
            builder: (context, state, navigationShell) {
              return BottomNavScreen(navigationShell: navigationShell);
            })
      ],
    );
  },
);
