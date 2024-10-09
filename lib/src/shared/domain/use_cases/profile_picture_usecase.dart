import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/shared/data/repository/media_repository_impl.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/dto/profile_picture_dto.dart';
import 'package:enigma/src/shared/domain/repository/media_repository.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class ImageMediaUsecase
    extends UseCase<Either<Failure, Success>, ImageMediaDto> {
  final MediaRepository _mediaRepository = sl.get<MediaRepositoryImpl>();

  @override
  Future<Either<Failure, Success>> call(ImageMediaDto params) async {
    return await _mediaRepository.addMediaImage(
      file: params.file,
      directory: params.directory,
      fileName: params.fileName,
    );
  }
}
