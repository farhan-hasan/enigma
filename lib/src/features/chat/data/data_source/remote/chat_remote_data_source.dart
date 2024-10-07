import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/id_hashing/id_hashing.dart';
import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';

class ChatRemoteDataSource {
  Future<Either<Failure, Success>> addChat(
      {required ChatEntity chatEntity}) async {
    Failure failure;
    try {
      String roomID = HashGenerator.idHashing(
        uid1: chatEntity.sender ?? "",
        uid2: chatEntity.receiver ?? "",
      );
      DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseHandler
          .fireStore
          .collection(FirestoreCollectionName.chatCollection)
          .doc(roomID)
          .get();
      if (ref.exists) {
        await FirebaseHandler.fireStore
            .collection(FirestoreCollectionName.chatCollection)
            .doc(roomID)
            .collection(FirestoreCollectionName.messageCollection)
            .doc()
            .set(chatEntity.toJson());
      } else {
        roomID = HashGenerator.idHashing(
          uid1: chatEntity.receiver ?? "",
          uid2: chatEntity.sender ?? "",
        );
        await FirebaseHandler.fireStore
            .collection(FirestoreCollectionName.chatCollection)
            .doc(roomID)
            .collection(FirestoreCollectionName.messageCollection)
            .doc()
            .set(chatEntity.toJson());
      }
      return Right(Success(message: "Message Sent Successfully"));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(message: "Handle permission denied error");
          break;
        case 'not-found':
          failure = Failure(message: "Handle document not found error");
          break;
        default:
          failure = Failure(message: "An unknown error occured");
          break;
      }
    }
    return Left(failure);
  }

  Stream<Either<Failure, List<ChatModel>>> getChat(
      {required String roomID}) async* {
    Failure failure;
    try {
      List<ChatModel> messages = [];
      DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseHandler
          .fireStore
          .collection(FirestoreCollectionName.chatCollection)
          .doc(roomID)
          .get();
      if (ref.exists) {
        Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
            FirebaseHandler.fireStore
                .collection(FirestoreCollectionName.chatCollection)
                .doc(roomID)
                .collection(FirestoreCollectionName.messageCollection)
                .snapshots();

        /// TODO: Return stream and listen from stream builder no need to go through all layers
      }
      // await FirebaseHandler.fireStore
      //     .collection(FirestoreCollectionName.profileCollection);
      yield Right(messages);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(message: "Handle permission denied error");
          break;
        case 'not-found':
          failure = Failure(message: "Handle document not found error");
          break;
        default:
          failure = Failure(message: "An unknown error occured");
          break;
      }
    }
    yield Left(failure);
  }
}
