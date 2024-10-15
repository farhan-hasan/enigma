import 'dart:convert';

import 'package:enigma/src/core/notification/local_notification/local_notification_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data["data"]}");
  print("Runtimetype: ${message.data.runtimeType}");
}

class PushNotificationHandler {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  PushNotificationHandler() {
    init();
  }

  init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      LocalNotificationHandler.showLocalNotification(
          "Push notification", "This is description");
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  static void _handleMessage(RemoteMessage message) {
    BuildContext context = rootNavigatorKey.currentState!.context;
    Map<String, dynamic> data = jsonDecode(message.data["data"]);
    GoRouter.of(context).goNamed("weather", extra: data);
    print("Data after opened from background: ${message.data["data"]}");
  }
}
