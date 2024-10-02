import 'package:enigma/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/core/utils/constants/icons_path.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/core/utils/validators/validator.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_elevated_button.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_form_field.dart';
import 'package:enigma/src/features/auth/presentation/components/or_widget.dart';
import 'package:enigma/src/features/auth/presentation/components/social_media_icon_button.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key}) {}
  static const route = "/login";

  static setRoute() => "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SharedPreferenceManager preferenceManager = sl.get();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t) {
      preferenceManager.insertValue<int>(
          key: SharedPreferenceKeys.CHECK_KEY, data: 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Log in to Enigma",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Welcome back! Sign in using your social account or email to continue',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
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
                        iconSource: IconsPath.appleDarkIcon,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: OrWidget(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                CustomFormField(
                  controller: emailController,
                  labelText: "Your Email",
                  validator: Validators.emailValidator,
                ),
                CustomFormField(
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: true,
                  validator: Validators.passwordValidator,
                ),
                SizedBox(height: context.height * 0.2),
                CustomElevatedButton(
                  buttonName: "Log in",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forget Password?"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
