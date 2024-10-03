import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/constants/collection_name.dart';
import 'package:enigma/src/features/profile/data/model/profile_model.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ProfileRemoteDataSource {
  Future<Either<Failure, ProfileModel>> createProfile({
    required ProfileEntity profileModel,
  }) async {
    Failure failure;
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(profileModel.uid)
          .set(profileModel.toJson());
      return Right(ProfileModel.fromJson(profileModel.toJson()));
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

  Future<Either<Failure, ProfileModel>> readProfile(
      {required String uid}) async {
    Failure failure;
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseHandler.fireStore
              .collection(FirestoreCollectionName.profileCollection)
              .doc(uid)
              .get();
      return Right(ProfileModel.fromJson(documentSnapshot.data() ?? {}));
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

  Future<Either<Failure, List<ProfileModel>>> readAllProfile(
      {FilterDto? filter}) async {
    Failure failure;
    List<ProfileModel> allProfile = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseHandler.get(
              collectionName: CollectionName.profileCollection,
              where: filter?.firebaseWhereModel);
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseHandler
          .fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .get();
      for (QueryDocumentSnapshot q in querySnapshot.docs) {
        allProfile.add(ProfileModel.fromJson(q.data() as Map<String, dynamic>));
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

  Future<Either<Failure, ProfileModel>> updateProfile(
      {required ProfileModel profileModel}) async {
    Failure failure;
    try {
      await FirebaseHandler.fireStore
          .collection(FirestoreCollectionName.profileCollection)
          .doc(profileModel.uid)
          .update(profileModel.toJson());
      return Right(profileModel);
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
