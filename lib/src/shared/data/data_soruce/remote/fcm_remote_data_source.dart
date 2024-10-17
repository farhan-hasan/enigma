import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FCMRemoteDataSource {
  Future<Either<Failure, Success>> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
  }) async {
    const String jsonSource = 'assets/data/enigma-credential.json';
    Failure failure;
    final jsonCredentials = await rootBundle.loadString(jsonSource);
    final creds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);

    final client = await auth.clientViaServiceAccount(
      creds,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    final notificationData = {
      'message': {
        'token': recipientToken,
        'notification': {
          'title': title,
          'body': body,
          'image':
              'https://static8.depositphotos.com/1026550/1036/i/950/depositphotos_10361062-stock-photo-shopping-cart-symbol-at-the.jpg/'
        },
      },
    };

    const String senderId = '1015120837572';
    final response = await client.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$senderId/messages:send'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(notificationData),
    );

    client.close();
    if (response.statusCode == 200) {
      return Right(
          Success(message: "Notification send successfully")); // Success!
    }

    // debug('Notification Sending Error Response status: ${response.statusCode}');
    // debug('Notification Response body: ${response.body}');
    failure = Failure(message: 'Notification Response body: ${response.body}');
    return Left(failure);
  }
}
