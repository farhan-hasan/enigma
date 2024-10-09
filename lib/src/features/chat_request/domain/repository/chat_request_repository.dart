import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';
import 'package:enigma/src/features/chat_request/domain/dto/friendship_dto.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';

abstract class ChatRequestRepository {
  Future<Either<Failure, ChatRequestModel>> sendChatRequest(
      {required ChatRequestEntity chatRequestEntity});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchPendingRequest(
      {FilterDto? filter});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchChatRequest(
      {FilterDto? filter});

  Future<Either<Failure, List<ChatRequestEntity>>> fetchFriends(
      {FilterDto? filter});

  Future<Either<Failure, Success>> updateRequestStatus(
      {required ChatRequestEntity chatRequestEntity});

  Future<Either<Failure, Success>> removeFriend(
      {required FriendShipDto friendShipDto});
}
