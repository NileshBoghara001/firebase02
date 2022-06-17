import 'package:firebase02/Screen/GlobleNotification.dart';
import 'package:firebase02/Screen/Home_Screen.dart';
import 'package:firebase02/Screen/Login_Screen.dart';
import 'package:firebase02/Screen/NotificationLocal.dart';
import 'package:firebase02/Screen/SpleshScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// STEP - 1
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// STEP - 2
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

// STEP - 3
AndroidNotificationChannel channel = AndroidNotificationChannel("1", "Android",importance: Importance.max);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

// STEP - 4
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // STEP - 5
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

// STEP - 6
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    badge: true,
    alert: true,
    sound: true,
  );


  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/globalnotification',
      routes: {
        '/': (context) => Login_Screen(),
        '/home': (context) => Home_Screen(),
        '/splesh': (context) => SpleshScreen(),
        '/notification': (context) => LocalNotification(),
        '/globalnotification': (context) => GlobleNotification(),
      },
    ),
  );
}

