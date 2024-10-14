import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/story/domain/dto/story_dto.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';

class StoryRemoteDataSource {
  Future<Either<Failure, Success>> addStory(
      {required StoryDto storyDto}) async {
    Failure failure = Failure(message: "");
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.storyCollection)
          .doc(storyDto.userStoryEntity.uid)
          .set(storyDto.userStoryEntity.toJson());
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.storyCollection)
          .doc(storyDto.userStoryEntity.uid)
          .collection(FirestoreCollectionName.storyListCollection)
          .doc()
          .set(storyDto.storyEntity.toJson());
      // DocumentReference docRef = FirebaseHandler.fireStore
      //     .collection(FirestoreCollectionName.storyCollection)
      //     .doc(storyEntity.uid);
      // await FirebaseHandler.fireStore.runTransaction((transaction) async {
      //   transaction.update(docRef, {
      //     'uid': storyEntity.uid,
      //   });
      //   DocumentReference subCollectionRef = docRef
      //       .collection(FirestoreCollectionName.storyListCollection)
      //       .doc();
      //   transaction.set(subCollectionRef, storyEntity.toJson());
      // });
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

  Future<Either<Failure, UserStoryEntity>> getStories(
      {required String uid}) async {
    Failure failure = Failure(message: "");

    List<StoryEntity> stories = [];
    UserStoryEntity userStoryEntity = UserStoryEntity();

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseHandler.fireStore
              .collection(FirestoreCollectionName.storyCollection)
              .doc(uid)
              .get();

      if (documentSnapshot.exists) {
        String uid = documentSnapshot.get("uid");
        String name = documentSnapshot.get("name");
        userStoryEntity.name = name;
        userStoryEntity.uid = uid;
      }

      QuerySnapshot querySnapshot = await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.storyCollection)
          .doc(uid)
          .collection(FirestoreCollectionName.storyListCollection)
          .get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        stories.add(StoryEntity.fromJson(data));
      }
      userStoryEntity.storyList = stories;
      return Right(userStoryEntity);
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
