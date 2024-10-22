import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';

abstract class FCMRepository {
  Future<Either<Failure, Success>> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
    PushBodyModel? data,
    required String imageUrl,
  });
}
