import 'package:enigma/src/core/utils/constants/icons_path.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_elevated_button.dart';
import 'package:enigma/src/features/auth/presentation/components/or_widget.dart';
import 'package:enigma/src/features/auth/presentation/components/social_media_icon_button.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:enigma/src/features/auth/presentation/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Connect friends easily & quickly',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Our chat app is the perfect way to stay connected with friends and family.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaIconButton(
                    iconSource: IconsPath.facebookIcon,
                    onPressed: () {},
                  ),
                  SocialMediaIconButton(
                    iconSource: IconsPath.googleIcon,
                    onPressed: () {},
                  ),
                  SocialMediaIconButton(
                    iconSource: IconsPath.appleIcon,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            OrWidget(
              color: Theme.of(context).splashColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                buttonName: "Sign Up with Mail",
                onPressed: () {
                  context.push(SignupScreen.setRoute());
                },
              ),
            ),
            InkWell(
              onTap: () {
                context.push(LoginScreen.setRoute());
              },
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(text: "Existing account?"),
                  TextSpan(text: "  Log in")
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
