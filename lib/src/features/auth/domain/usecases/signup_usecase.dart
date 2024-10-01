import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:enigma/src/features/auth/domain/dto/signup_dto.dart';
import 'package:enigma/src/features/auth/domain/repository/auth_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupUseCase extends UseCase<Either<Failure, User>, SignupDto> {
  AuthRepository authRepository = sl.get<AuthRepositoryImpl>();
  @override
  Future<Either<Failure, User>> call(SignupDto params) async {
    return await authRepository.signUp(
        email: params.email, password: params.password);
  }
}
