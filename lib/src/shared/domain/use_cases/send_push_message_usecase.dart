import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/shared/data/repository/fcm_repository_impl.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/dto/fcm_dto.dart';
import 'package:enigma/src/shared/domain/repository/fcm_repository.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class SendPushMessageUsecase extends UseCase<Either<Failure, Success>, FCMDto> {
  final FCMRepository _fcmRepository = sl.get<FCMRepositoryImpl>();

  @override
  Future<Either<Failure, Success>> call(FCMDto params) async {
    Either<Failure, Success> response = await _fcmRepository.sendPushMessage(
        recipientToken: params.recipientToken,
        title: params.title,
        body: params.body,
        imageUrl: params.imageUrl);
    return response;
  }
}
