import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/document_finder.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/id_hashing/id_hashing.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';

class ChatRemoteDataSource {
  Future<Either<Failure, Success>> addChat(
      {required ChatEntity chatEntity}) async {
    Failure failure;
    try {
      String roomID = HashGenerator.idHashing(
        myUid: chatEntity.sender ?? "",
        friendUid: chatEntity.receiver ?? "",
      );
      bool doesExist = await DocumentFinder.checkExistence(roomID: roomID);
      if (doesExist) {
        await FirebaseHandler.fireStore
            .collection(FirestoreCollectionName.chatCollection)
            .doc(roomID).set({"roomID" : roomID});
        await FirebaseHandler.fireStore
            .collection(FirestoreCollectionName.chatCollection)
            .doc(roomID)
            .collection(FirestoreCollectionName.messageCollection)
            .doc()
            .set(chatEntity.toJson());
      } else {
        roomID = HashGenerator.idHashing(
          myUid: chatEntity.receiver ?? "",
          friendUid: chatEntity.sender ?? "",
        );
        await FirebaseHandler.fireStore
            .collection(FirestoreCollectionName.chatCollection)
            .doc(roomID).set({"roomID" : roomID});
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

  Future<Stream<List<ChatModel>>> getChat(
      {required String myUid, required String friendUid}) async {
    Failure failure;
    try {
      String roomID = HashGenerator.idHashing(
        myUid: myUid,
        friendUid: friendUid,
      );
      bool doesExist = await DocumentFinder.checkExistence(roomID: roomID);
      // debug(roomID);
      // debug(doesExist);
      if (!doesExist) {
        roomID = HashGenerator.idHashing(
          myUid: friendUid,
          friendUid: myUid,
        );
      }
      // debug(roomID);
      // debug(doesExist);

      Stream<List<ChatModel>> querySnapshot = FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.chatCollection)
          .doc(roomID)
          .collection(FirestoreCollectionName.messageCollection)
          .snapshots()
          .map((documentList) {
        return documentList.docs
            .map((r) => ChatModel.fromJson(r.data()))
            .toList();
      });
      // debug("From Remote Data Source: ${querySnapshot.runtimeType}");
      return querySnapshot;
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
    return Stream.value([]);
  }
}
