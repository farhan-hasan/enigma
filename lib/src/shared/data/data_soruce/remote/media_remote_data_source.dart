import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/storage_directory_name.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaRemoteDataSource {
  Future<Either<Failure, Success>> addProfileImage({
    required File file,
    required String uid,
  }) async {
    Failure failure;
    Reference storageRef = FirebaseHandler.storage.ref();
    Reference profileDirectory =
        storageRef.child(StorageDirectoryName.PROFILE_DIRECTORY).child(uid);
    try {
      String profileImageUrl;
      await profileDirectory.putFile(file);
      profileImageUrl = await profileDirectory.getDownloadURL();
      return Right(Success(message: profileImageUrl));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'object-not-found':
          failure =
              Failure(message: 'No object exists at the desired reference.');
          break;
        case 'unauthorized':
          failure = Failure(
              message: 'User does not have permission to access the object.');
          break;
        case 'cancelled':
          failure = Failure(message: 'User canceled the operation.');
          break;
        case 'unknown':
          failure = Failure(
              message: 'Unknown error occurred, inspect the server response.');
          break;
        default:
          failure = Failure(message: 'Something went wrong: ${e.message}');
          break;
      }
    } catch (e) {
      failure = Failure(message: 'Error: $e');
    }
    return Left(failure);
  }
}
