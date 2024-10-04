import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';

abstract class ChatRequestRepository {
  Future<Either<Failure, ChatRequestModel>> sendChatRequest(
      {required ChatRequestEntity chatRequestEntity});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchChatRequests(
      String uid);
}
