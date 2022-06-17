import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class GlobleNotification extends StatefulWidget {
  const GlobleNotification({Key? key}) : super(key: key);

  @override
  State<GlobleNotification> createState() => _GlobleNotificationState();
}

class _GlobleNotificationState extends State<GlobleNotification> {


  @override
  void initState() {
    super.initState();

// STEP - 7
    AndroidInitializationSettings androidinit = AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosInit = IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings( android: androidinit,iOS: iosInit);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelect);

// STEP - 8
    FirebaseMessaging.onMessage.listen((message) {

      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;

      if(remoteNotification!=null || androidNotification!=null)
        {

          AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name,importance: Importance.max,priority: Priority.high);

          flutterLocalNotificationsPlugin.show(remoteNotification.hashCode, remoteNotification!.title, remoteNotification.body, NotificationDetails(android:  androidNotificationDetails));
        }
    });


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Global Notification"),
        ),
        body: Container(

        ),
      ),
    );
  }

  // STEP - 9
  void onSelect(String? payload) {



  }
}
