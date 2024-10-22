import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/shared/data/data_soruce/remote/fcm_remote_data_source.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';
import 'package:enigma/src/shared/domain/repository/fcm_repository.dart';

class FCMRepositoryImpl extends FCMRepository {
  final FCMRemoteDataSource _fcmRemoteDataSource = FCMRemoteDataSource();

  @override
  Future<Either<Failure, Success>> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
    PushBodyModel? data,
    required String imageUrl,
  }) async {
    Either<Failure, Success> response =
        await _fcmRemoteDataSource.sendPushMessage(
      recipientToken: recipientToken,
      title: title,
      body: body,
      data: data,
      imageUrl: imageUrl,
    );
    return response;
  }
}
