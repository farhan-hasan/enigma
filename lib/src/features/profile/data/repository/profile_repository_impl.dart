import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource =
      ProfileRemoteDataSource();

  @override
  Future<Either<Failure, ProfileModel>> createProfile(
      {required ProfileEntity profileEntity}) async {
    Either<Failure, ProfileModel> response = await _profileRemoteDataSource
        .createProfile(profileEntity: profileEntity);

    return response;
  }

  @override
  Future<Either<Failure, List<ProfileModel>>> readAllProfile(
      {FilterDto? filter}) async {
    Either<Failure, List<ProfileModel>> response =
        await _profileRemoteDataSource.readAllProfile(filter: filter);
    return response;
  }

  @override
  Future<Either<Failure, ProfileEntity>> readProfile(
      {required String uid}) async {
    Either<Failure, ProfileEntity> response =
        await _profileRemoteDataSource.readProfile(uid: uid);
    return response;
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile(
      {required ProfileEntity profileEntity}) async {
    Either<Failure, ProfileModel> response = await _profileRemoteDataSource
        .updateProfile(profileModel: profileEntity.toModel());
    return response;
  }

  @override
  Future<Either<Failure, Success>> deleteProfile(
      {required ProfileEntity profileEntity}) async {
    Either<Failure, Success> response = await _profileRemoteDataSource
        .deleteProfile(profileModel: profileEntity.toModel());
    return response;
  }
}
