import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/data/data_source/remote/chat_request_remote_data_source.dart';
import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/domain/repository/chat_request_repository.dart';

class ChatRequestRepositoryImpl extends ChatRequestRepository {
  final ChatRequestRemoteDataSource _chatRequestRemoteDataSource =
      ChatRequestRemoteDataSource();

  @override
  Future<Either<Failure, ChatRequestModel>> sendChatRequest(
      {required ChatRequestEntity chatRequestEntity}) async {
    Either<Failure, ChatRequestModel> response =
        await _chatRequestRemoteDataSource.sendChatRequest(
            chatRequestEntity: chatRequestEntity);

    return response;
  }

  @override
  Future<Either<Failure, List<ChatRequestEntity>>> fetchChatRequests(
      String uid) async {
    Either<Failure, List<ChatRequestEntity>> response =
        await _chatRequestRemoteDataSource.fetchChatRequests(uid);

    return response;
  }
}
