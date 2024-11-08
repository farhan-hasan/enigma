import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FCMRemoteDataSource {
  Future<Either<Failure, Success>> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
    PushBodyModel? data,
    required String imageUrl,
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
          'image': imageUrl,
        },
        'android': {
          'notification': {"click_action": "OPEN_ACTIVITY_1"},
          'priority': 'high',
        },
        'data': (data?.toJson()) ?? {}
      },
    };

    if (!(data?.showNotification ?? true)) {
      try {
        notificationData['message']?.remove('notification');
      } catch (e) {}
    }

    const String senderId = '1015120837572';
    final response = await client.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$senderId/messages:send'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(notificationData),
    );

    print(
        "Push notification status ${data?.toJson()}-${response.statusCode}-${response.body}");

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
