import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:enigma/src/core/app/app.dart';
import 'package:enigma/src/core/global/global_variables.dart';
import 'package:enigma/src/core/notification/local_notification/local_notification_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/voice_call/data/model/call_model.dart';
import 'package:enigma/src/features/voice_call/presentation/view_model/call_controller.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:go_router/go_router.dart';

@pragma("vm:entry-point")
enum AppMode { FOREGROUND, BACKGROUND, TERMINATED, REVIVED }

@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  print("Runtimetype: ${message.data.runtimeType}");
  await Firebase.initializeApp();
  PushNotificationHandler.handleMessage(message, AppMode.TERMINATED);
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

    /// Foreground State
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => handleMessage(message, AppMode.FOREGROUND),
    );

    /// Background State
    FirebaseMessaging.onMessageOpenedApp.listen(
      (data) => handleMessage(data, AppMode.BACKGROUND),
    );
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage, AppMode.REVIVED);
    }
  }

  static void handleMessage(RemoteMessage message, AppMode appMode) {
    Map<String, dynamic> data = message.data;
    PushBodyModel pushBodyModel = PushBodyModel.fromJson(data);
    debug(message.data["type"]);
    if (appMode == AppMode.FOREGROUND) {
      if (pushBodyModel.type == 'incoming_call') {
        container.read(callProvider.notifier).showCallDialog(
              pushBodyModel: pushBodyModel,
            );
      } else {

        LocalNotificationHandler.showLocalNotification(
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? "",
        );
      }
    }
    else {
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
      } else if (pushBodyModel.type == "message") {
        debug(message.data);
      }
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
