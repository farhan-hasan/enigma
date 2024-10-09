import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/auth/presentation/logout/view_model/logout_controller.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";

  static setRoute() => "/profile";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppbar(
        trailingWidgets: [
          GestureDetector(
            onTap: () {
              ref.read(logoutProvider.notifier).logout();
            },
            child: Container(
              height: context.height * .15,
              width: context.width * .137,
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
