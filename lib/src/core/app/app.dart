import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/styles/theme/app_theme.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});
  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appInitialization = ref.watch(appInitializationProvider);
    return appInitialization.when(data: (data) {
      final router = ref.watch(goRouterProvider);
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,

        title: 'Enigma',
        builder: BotToastInit(),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.light,
      );
    }, error: (e, s) {
      debug("appInitialization error ${e}");
      return SizedBox.shrink();
    }, loading: () {
      return SizedBox.shrink();
    });
  }
}
