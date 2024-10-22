import 'package:enigma/src/core/notification/push_notification/push_notification_handler.dart';
import 'package:enigma/src/core/utils/validators/validator.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_elevated_button.dart';
import 'package:enigma/src/features/auth/presentation/components/custom_form_field.dart';
import 'package:enigma/src/features/auth/presentation/forget_password/view_model/forgot_password_controller.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});

  static String route = "/forget_password";

  static get setRoute => "/forget_password";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: SharedAppbar(
        title: Text("Enigma"),
        leadingWidget: InkWell(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please enter your email address below and click "
                "the 'Get Reset Link' button. We will send you a "
                "link to given email for changing your password.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              CustomFormField(
                controller: emailController,
                labelText: "Email",
                validator: Validators.emailValidator,
              ),
              CustomElevatedButton(
                buttonName: "Get Reset Link",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(forgotPasswordProvider.notifier)
                        .sendPasswordResetEmail(
                          email: emailController.text.trim(),
                        );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
