import 'package:enigma/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:enigma/src/features/auth/presentation/login/view_model/login_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<LoginGeneric> {
  LoginController(this.ref) : super(LoginGeneric());
  Ref ref;

  LoginUseCase loginUseCase = sl.get<LoginUseCase>();
}
