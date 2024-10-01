import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/styles/theme/enigma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Enigma',
      builder: BotToastInit(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      darkTheme: customDarkTheme,
      theme: customLightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
