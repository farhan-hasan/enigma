import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // Todo: Implement PopScope
  Future<bool> _handleBackButton(BuildContext context) async {
    // Custom logic for back button handling
    // For example, show a confirmation dialog
    final bool shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Enigma'),
            content: const Text('Do you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;

    if (shouldPop) {
      // Navigate back using go_router
      context.pop();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SizedBox(
        height: context.height * .08,
        child: BottomNavigationBar(
            iconSize: 25,
            onTap: (index) {
              navigationShell.goBranch(index,
                  initialLocation: index == navigationShell.currentIndex);
            },
            currentIndex: navigationShell.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger_outline_rounded),
                label: "Message",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: "People",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "Settings",
              ),
            ]),
      ),
    );
  }
}
