import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';

abstract class MediaRepository {
  Future<Either<Failure, Success>> addMediaImage(
      {required File file,
      required String directory,
      required String fileName});
}
