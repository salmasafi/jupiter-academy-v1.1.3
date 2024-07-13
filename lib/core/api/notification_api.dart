import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configLocalNotifi() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          '6126',
          'jupiter',
          importance: Importance.max,
          priority: Priority.high,
          autoCancel: false,
        );

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, platformChannelSpecifics);
      }
    });

    

    
  }

  Future<void> initNotifacations() async {
    await _firebaseMessaging.requestPermission();
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fCMToken = _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted permission');
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print(
            'title: ${message.notification!.title.toString()} | body: ${message.notification!.body.toString()}');
      },
    );
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
    required String page,
    required String employeeId,
  }) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendNotification');

    try {
      final response = await callable.call(<String, dynamic>{
        'token': token,
        'title': title,
        'body': body,
        'page': page,
        'employeeId': employeeId,
      });

      if (response.data['success']) {
        print('Notification sent successfully.');
        //return true;
      } else {
        print('Failed to send notification: ${response.data['error']}');
        //return false;
      }
    } catch (e) {
      print('There is an error $e');
      //return false;
    }
  }
}

