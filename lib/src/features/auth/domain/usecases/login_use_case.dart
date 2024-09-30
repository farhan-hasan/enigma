import 'package:enigma/src/features/auth/data/repository/login_repository_impl.dart';
import 'package:enigma/src/features/auth/domain/repository/login_repository.dart';

class LoginUseCase {
  LoginRepository loginRepository = LoginRepositoryImpl();

  Future call() async {
    return loginRepository.login();
  }
}
