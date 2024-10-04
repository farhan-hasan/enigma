import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';

class ChatRequestRemoteDataSource {
  Future<Either<Failure, ChatRequestModel>> sendChatRequest(
      {required ChatRequestEntity chatRequestEntity}) async {
    Failure failure;
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(chatRequestEntity.receiverUid)
          .collection(FirestoreCollectionName.friendsCollection)
          .doc(chatRequestEntity.senderUid)
          .set(chatRequestEntity.toJson());
      return Right(chatRequestEntity.toModel());
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors with switch-case on the error code
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(
              message: "You don't have permission to perform this action.");
          break;
        case 'unavailable':
          failure = Failure(
              message:
                  "Firestore service is currently unavailable. Please try again later.");
          break;
        case 'not-found':
          failure = Failure(message: "The requested document was not found.");
          break;
        case 'already-exists':
          failure = Failure(message: "The document already exists.");
          break;
        case 'cancelled':
          failure = Failure(message: "The operation was cancelled.");
          break;
        case 'deadline-exceeded':
          failure = Failure(
              message:
                  "The operation took too long to complete. Please try again.");
          break;
        case 'invalid-argument':
          failure = Failure(
              message:
                  "Invalid data provided. Please check the input and try again.");
          break;
        case 'network-error':
          failure = Failure(
              message:
                  "A network error occurred. Please check your connection.");
          break;
        default:
          failure = Failure(
              message: e.message ?? "An unknown Firebase error occurred.");
          break;
      }
    } catch (e) {
      // Handle any other generic errors
      failure =
          Failure(message: "An unexpected error occurred: ${e.toString()}");
    }
    return Left(failure);
  }

  Future<Either<Failure, List<ChatRequestEntity>>> fetchChatRequests(
      String uid) async {
    List<ChatRequestEntity> listOfChatRequestEntity = [];
    Failure failure = Failure(message: "");
    try {
      QuerySnapshot querySnapshot = await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(uid)
          .collection(FirestoreCollectionName.friendsCollection)
          .get();
      debug("querysnapshot = $querySnapshot");
      for (QueryDocumentSnapshot q in querySnapshot.docs) {
        listOfChatRequestEntity
            .add(ChatRequestEntity.fromJson(q.data() as Map<String, dynamic>));
      }
      debug("list = $listOfChatRequestEntity");
      return Right(listOfChatRequestEntity);
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors with switch-case
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(
              message: "You don't have permission to perform this action.");
          break;
        case 'unavailable':
          failure = Failure(
              message:
                  "Firestore service is currently unavailable. Please try again later.");
          break;
        case 'not-found':
          failure = Failure(message: "The requested document was not found.");
          break;
        case 'cancelled':
          failure = Failure(message: "The operation was cancelled.");
          break;
        case 'deadline-exceeded':
          failure = Failure(
              message:
                  "The operation took too long to complete. Please try again.");
          break;
        case 'network-error':
          failure = Failure(
              message:
                  "A network error occurred. Please check your connection.");
          break;
        default:
          failure = Failure(
              message: e.message ?? "An unknown Firebase error occurred.");
          break;
      }
    } catch (e) {
      // Handle any other generic errors
      failure =
          Failure(message: "An unexpected error occurred: ${e.toString()}");
      debug(e.toString());
    }
    return Left(failure);
  }
}
