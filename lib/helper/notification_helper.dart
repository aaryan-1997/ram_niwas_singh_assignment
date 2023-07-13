import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initIOSSettings = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationsSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: initIOSSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (details) {
        log(details.payload ?? "payload");
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        log("onMessage: ${message.notification!.title}/${message.notification!.body}");
        NotificationHelper.showNotification(
            message, flutterLocalNotificationsPlugin, false);
      } catch (e) {
        log("_error_ onMessage$e");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      try {
        log("onOpenApp: ${message.notification!.title}/${message.notification!.body}");
      } catch (e) {
        log("_error_ onOpenApp$e");
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    String title;
    String body;
    if (data) {
      title = message.data['title'];
      body = message.data['body'];
    } else {
      title = message.notification!.title!;
      body = message.notification!.body!;
    }
    await showTextNotification(title, body, fln);
  }

  static Future<void> showTextNotification(
      String title, String body, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'assignment',
      'assignment name',
      channelDescription: 'assignment description',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: "payload");
  }

  
  void requestPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    }
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  try {
    log("onBackground: ${message.notification!.title}/${message.notification!.body}");
  } on Exception catch (e) {
    log("myBackgroundMessageHandler_error=>$e");
  }
}
