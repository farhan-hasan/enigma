import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/repository/profile_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class DeleteProfileUseCase
    extends UseCase<Either<Failure, Success>, ProfileEntity> {
  ProfileRepository _profileRepository = sl.get<ProfileRepositoryImpl>();

  @override
  Future<Either<Failure, Success>> call(ProfileEntity params) async {
    return await _profileRepository.deleteProfile(profileEntity: params);
  }
}
