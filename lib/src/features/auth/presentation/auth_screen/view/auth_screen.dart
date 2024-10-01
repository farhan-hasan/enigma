import 'package:enigma/src/core/utils/constants/icons_path.dart';
import 'package:enigma/src/features/auth/presentation/components/social_media_icon_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const route = '/auth_screen';

  static setRoute() => '/auth_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "E ",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              "Enigma",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Connect friends easily & quickly',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              'Our chat app is the perfect way to stay connected with friends and family.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            Row(
              children: [
                socialMediaButton(IconsPath.facebookIcon, () {}),
                socialMediaButton(IconsPath.appleIcon, () {}),
                socialMediaButton(IconsPath.googleIcon, () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
