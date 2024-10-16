import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/auth/domain/usecases/change_email_usecase.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_generic.dart';

final authProvider = StateNotifierProvider<AuthController, AuthGeneric>(
    (ref) => AuthController(ref));

class AuthController extends StateNotifier<AuthGeneric> {
  AuthController(this.ref) : super(AuthGeneric());
  Ref ref;

  ChangeEmailUseCase changeEmailUseCase = sl.get<ChangeEmailUseCase>();
  final SharedPreferenceManager preferenceManager = sl.get();

  Future<bool> changeEmail({required String email}) async {
    state = state.update(isLoading: true);
    bool isSuccess = false;
    Either<Failure, Success> response = await changeEmailUseCase.call(email);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) async {
        BotToast.showText(text: right.message);
        isSuccess = true;
      },
    );
    state = state.update(isLoading: false);
    return isSuccess;
  }
}
