import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/auth/domain/dto/signup_dto.dart';
import 'package:enigma/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:enigma/src/features/auth/presentation/signup/view_model/signup_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignupController, SignupGeneric>(
  (ref) => SignupController(ref),
);

class SignupController extends StateNotifier<SignupGeneric> {
  SignupController(this.ref) : super(SignupGeneric());
  Ref ref;

  SignupUseCase signupUseCase = sl.get<SignupUseCase>();

  signUp({required String email, required String password}) async {
    SignupDto params = SignupDto(email: email, password: password);
    Either<Failure, User> response = await signupUseCase.call(params);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {
        BotToast.showText(text: "Account created successfully.");
      },
    );
  }
}
