import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/firestore_collection_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ProfileRemoteDataSource {
  Future<Either<Failure, ProfileModel>> createProfile({
    required ProfileEntity profileEntity,
  }) async {
    Failure failure;
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(profileEntity.uid)
          .set(profileEntity.toJson());
      return Right(profileEntity.toModel());
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

  Future<Either<Failure, ProfileEntity>> readProfile(
      {required String uid}) async {
    Failure failure;
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseHandler.fireStore
              .collection(FirestoreCollectionName.profileCollection)
              .doc(uid)
              .get();
      return Right(ProfileEntity.fromJson(documentSnapshot.data() ?? {}));
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
    }
    return Left(failure);
  }

  Future<Either<Failure, List<ProfileEntity>>> readAllProfile(
      {FilterDto? filter}) async {
    Failure failure;
    List<ProfileEntity> allProfile = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseHandler.get(
              collectionName: FirestoreCollectionName.profileCollection,
              where: filter?.firebaseWhereModel);

      for (QueryDocumentSnapshot q in querySnapshot.docs) {
        allProfile
            .add(ProfileEntity.fromJson(q.data() as Map<String, dynamic>));
      }
      return Right(allProfile);
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
    }
    return Left(failure);
  }

  Future<Either<Failure, ProfileEntity>> updateProfile(
      {required ProfileEntity profileEntity}) async {
    Failure failure;
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(profileEntity.uid)
          .update(profileEntity.toJson());
      return Right(profileEntity);
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
    }
    return Left(failure);
  }

  Future<Either<Failure, Success>> deleteProfile(
      {required ProfileModel profileModel}) async {
    Failure failure;

    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(profileModel.uid)
          .delete();
      return Right(Success(message: "Profile deleted successfully"));
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
    }
    return Left(failure);
  }
}
