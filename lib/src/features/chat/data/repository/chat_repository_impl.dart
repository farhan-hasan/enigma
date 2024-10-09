import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/chat/data/data_source/remote/chat_remote_data_source.dart';
import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  ChatRemoteDataSource _chatRemoteDataSource = ChatRemoteDataSource();

  @override
  Future<Either<Failure, Success>> addChat(
      {required ChatEntity chatEntity}) async {
    Either<Failure, Success> response =
        await _chatRemoteDataSource.addChat(chatEntity: chatEntity);
    return response;
  }

  @override
  Future<Stream<List<ChatModel>>> getChat(
      {required String myUid, required String friendUid}) async {
    Stream<List<ChatModel>> response =
        await _chatRemoteDataSource.getChat(myUid: myUid, friendUid: friendUid);

    return response;
  }

// @override
// Future<Either<Failure, List<ChatModel>>> getChat(
//     {required String roomID}) async {
//   Either<Failure, List<ChatModel>> response =
//       await _chatRemoteDataSource.getChat(roomID: roomID);
//   return response;
// }
}
