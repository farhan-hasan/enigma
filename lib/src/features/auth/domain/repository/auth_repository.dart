import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, User>> signUp(
      {required String email, required String password});
  Future<Either<Failure, Success>> logout();
  Future<Either<Failure, Success>> changePassword({required String password});
  Future<Either<Failure, Success>> forgotPassword({required String email});
  Future<Either<Failure, Success>> updateEmail({required String email});
}
