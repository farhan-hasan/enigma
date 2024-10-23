import 'dart:convert';

import 'package:enigma/src/core/global/global_variables.dart';
import 'package:enigma/src/core/notification/local_notification/local_notification_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat_request/presentation/view/friends_screen.dart';
import 'package:enigma/src/features/voice_call/data/model/call_model.dart';
import 'package:enigma/src/features/voice_call/presentation/view/call_screen.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

// Lisitnening to the background messages

// Future<void> showCallkitIncoming(String uuid) async {
//
// }

@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  print("Runtimetype: ${message.data.runtimeType}");
  await Firebase.initializeApp();
  PushNotificationHandler.handleMessage(message);
}

@pragma("vm:entry-point")
class PushNotificationHandler {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  PushNotificationHandler() {
    init();
  }

  init() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // // push notification while in foreground
      // print(message.);
      LocalNotificationHandler.showLocalNotification(
        title: message.data['title'],
        body: message.data['body'],
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }
  }

  static void handleMessage(RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    PushBodyModel pushBodyModel = PushBodyModel.fromJson(data);
    if (pushBodyModel.type == "incoming_call") {
      CallModel callModel = CallModel.fromJson(jsonDecode(pushBodyModel.body));
      showCallkitIncoming(callModel);
      // print("Going to friend screen");
      // try {
      //   Navigator.of(rootNavigatorKey.currentContext!).push(MaterialPageRoute(
      //     builder: (context) =>
      //         CallScreen(callModel: callModel, isCalling: false),
      //   ));
      // } catch (e) {
      //   print("Handle Message Error: $e");
      // }
    }
  }

  static void showCallkitIncoming(CallModel callModel) async {
    final params = CallKitParams(
      id: callModel.channelId,
      nameCaller: '${callModel.senderName}',
      appName: 'Enigma',
      avatar: '${callModel.senderAvatar}',
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        // callbackText: 'Call back',
      ),
      extra: callModel.toJson(),
      // android: const AndroidParams(
      //   isCustomNotification: true,
      //   isShowLogo: false,
      //   ringtonePath: 'system_ringtone_default',
      //   backgroundColor: '#0955fa',
      //   backgroundUrl: 'assets/test.png',
      //   actionColor: '#4CAF50',
      //   textColor: '#ffffff',
      // ),
      // ios: const IOSParams(
      //   iconName: 'CallKitLogo',
      //   handleType: '',
      //   supportsVideo: true,
      //   maximumCallGroups: 2,
      //   maximumCallsPerCallGroup: 1,
      //   audioSessionMode: 'default',
      //   audioSessionActive: true,
      //   audioSessionPreferredSampleRate: 44100.0,
      //   audioSessionPreferredIOBufferDuration: 0.005,
      //   supportsDTMF: true,
      //   supportsHolding: true,
      //   supportsGrouping: false,
      //   supportsUngrouping: false,
      //   ringtonePath: 'system_ringtone_default',
      // ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
