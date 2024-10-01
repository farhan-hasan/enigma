import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/core/utils/validators/validator.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_elevated_button.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_form_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  static const route = '/signup';

  static setRoute() => '/signup';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign up with Email",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Get chatting with friends and family today by signing up for our chat app',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: context.height * 0.1),
                CustomFormField(
                  controller: nameController,
                  labelText: "Your Name",
                  validator: (val) {},
                ),
                CustomFormField(
                  controller: emailController,
                  labelText: "Your Email",
                  validator: Validators.emailValidator,
                ),
                CustomFormField(
                  controller: passwordController,
                  labelText: "Password",
                  validator: Validators.passwordValidator,
                ),
                CustomFormField(
                  controller: confirmPasswordController,
                  labelText: "Confirm Password",
                  validator: (val) {},
                ),
                SizedBox(height: context.height * 0.1),
                CustomElevatedButton(
                  buttonName: "Create an Account",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
