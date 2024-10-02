import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/repository/profile_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class UpdateProfileUseCase
    extends UseCase<Either<Failure, ProfileEntity>, ProfileEntity> {
  final ProfileRepository _profileRepository = sl.get<ProfileRepositoryImpl>();

  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileEntity params) async {
    Either<Failure, ProfileModel> response =
        await _profileRepository.updateProfile(profileEntity: params);
    return response.map((profileModel) => profileModel.toEntity());
  }
}
