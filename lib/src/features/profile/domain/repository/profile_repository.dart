import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> createProfile(
      {required ProfileEntity profileEntity});

  Future<Either<Failure, ProfileEntity>> readProfile({required String uid});

  Future<Either<Failure, List<ProfileEntity>>> readAllProfile(
      {FilterDto? filter});

  Future<Either<Failure, ProfileEntity>> updateProfile(
      {required ProfileEntity profileEntity});

  Future<Either<Failure, Success>> deleteProfile(
      {required ProfileEntity profileEntity});
}
