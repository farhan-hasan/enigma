import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/repository/profile_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class ReadAllPeopleUseCase
    extends UseCase<Either<Failure, List<ProfileEntity>>, FilterDto?> {
  ProfileRepository _profileRepository = sl.get<ProfileRepositoryImpl>();

  @override
  Future<Either<Failure, List<ProfileEntity>>> call(FilterDto? params) async {
    Either<Failure, List<ProfileModel>> response =
        await _profileRepository.readAllProfile(filter: params);

    return response.map((listProfileModel) => listProfileModel
        .map(
          (e) => e.toEntity(),
        )
        .toList());
  }
}
