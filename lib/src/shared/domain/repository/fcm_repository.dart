import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';

abstract class FCMRepository {
  Future<Either<Failure, Success>> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
    required String imageUrl,
  });
}
