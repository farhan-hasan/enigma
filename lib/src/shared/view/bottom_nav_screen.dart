import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

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
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.phone_in_talk_outlined), label: "Calls"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "People"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: "Settings"),
            ]),
      ),
    );
  }
}
