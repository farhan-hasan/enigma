import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

class StoryRemoteDataSource {
  Future<Either<Failure, Success>> addStory(
      {required StoryEntity storyEntity}) async {
    Failure failure = Failure(message: "");
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.storyCollection)
          .doc(storyEntity.uid)
          .collection(FirestoreCollectionName.storyListCollection)
          .doc()
          .set(storyEntity.toJson());
      return Right(Success(message: "Story added successfully"));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(message: "Handle permission denied error");
          break;
        case 'not-found':
          failure = Failure(message: "Handle document not found error");
          break;
        default:
          failure = Failure(message: "An unknown error occurred");
          break;
      }
    } catch (e) {
      failure = Failure(message: "An unknown error occurred");
    }

    return Left(failure);
  }

  Future<Either<Failure, List<StoryEntity>>> getStories(
      {required String uid}) async {
    Failure failure = Failure(message: "");

    List<StoryEntity> stories = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.storyCollection)
          .doc(uid)
          .collection(FirestoreCollectionName.storyListCollection)
          .get();
      debug("check");
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        stories.add(StoryEntity.fromJson(data));
      }
      return Right(stories);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          failure = Failure(message: "Handle permission denied error");
          break;
        case 'not-found':
          failure = Failure(message: "Handle document not found error");
          break;
        default:
          failure = Failure(message: "An unknown error occurred");
          break;
      }
    } catch (e) {
      failure = Failure(message: "An unknown error occurred");
      debug(e.toString());
    }

    return Left(failure);
  }
}
