import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';

abstract class ChatRequestRepository {
  Future<Either<Failure, ChatRequestModel>> sendChatRequest(
      {required ChatRequestEntity chatRequestEntity});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchPendingRequest(
      {FilterDto? filter});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchChatRequest(
      {FilterDto? filter});
}
