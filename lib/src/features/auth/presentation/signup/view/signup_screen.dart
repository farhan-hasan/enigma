import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/core/utils/validators/validator.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_elevated_button.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_form_field.dart';
import 'package:enigma/src/features/auth/presentation/signup/view_model/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // final signupController = ref.watch(signUpProvider);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign up with Email",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  validator: (val) {
                    if (val?.trim() != passwordController.text.trim()) {
                      return "Password Not Matched";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.height * 0.1),
                CustomElevatedButton(
                  buttonName: "Create an Account",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(signUpProvider.notifier).signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    }
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
