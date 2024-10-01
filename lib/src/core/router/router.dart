import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:enigma/src/features/message/domain/entity/message_entity.dart';
import 'package:enigma/src/features/message/presentation/view/message_screen.dart';
import 'package:enigma/src/shared/view/bottom_nav_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
