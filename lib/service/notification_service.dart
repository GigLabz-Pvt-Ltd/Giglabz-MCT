import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mycareteam/screens/home/home_screen.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print(message.notification);
  print(message.data);
  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
}

class NotificationService{
  FirebaseMessaging messaging= FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin=FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async{
    NotificationSettings settings=await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print('accepted');
    }
    else{
      print('denied');
    }
  }

  Future<String> getToken() async{
    String? token=await messaging.getToken();
    return token!;
  }

  void isTokenChanged() async{
    messaging.onTokenRefresh.listen((event) {event.toString();});
  }

  void handleLocalNotif(BuildContext context, RemoteMessage message) async{
    var androidInitial = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitial = DarwinInitializationSettings();
    await _notificationsPlugin.initialize(InitializationSettings(android: androidInitial, iOS: iosInitial),
        onDidReceiveNotificationResponse: (payload) {
          navigateToScreen(context, message);
        },
        onDidReceiveBackgroundNotificationResponse: (payload) {
          navigateToScreen(context, message);
        }
    );
  }

  void firebaseInit(BuildContext context) async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
      print(message.notification);
      print(message.data);
      showNotifications(message);
      navigateToScreen(context, message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
      print(message.notification);
      print(message.data);
      navigateToScreen(context, message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> showNotifications(RemoteMessage message) async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        "High Importance Notifications",
        importance: Importance.max
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id.toString(),
            channel.name.toString(),
            channelDescription: "Something",
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker'
        ),
        iOS: DarwinNotificationDetails()
    );

    Future.delayed(
        Duration.zero, (){
      _notificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails
      );
    }
    );
  }

  void navigateToScreen(BuildContext context, RemoteMessage message){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
  }
}