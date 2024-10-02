import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:enigma/src/features/auth/domain/dto/login_dto.dart';
import 'package:enigma/src/features/auth/domain/repository/auth_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase extends UseCase<Either<Failure, User>, LoginDto> {
  AuthRepository _authRepository = sl.get<AuthRepositoryImpl>();

  @override
  Future<Either<Failure, User>> call(LoginDto params) async {
    return await _authRepository.login(
        email: params.email, password: params.password);
  }
}
