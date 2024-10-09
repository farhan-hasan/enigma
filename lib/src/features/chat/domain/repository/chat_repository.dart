import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Success>> addChat({required ChatEntity chatEntity});
  Future<Stream<List<ChatModel>>> getChat(
      {required String myUid, required String friendUid});
}
