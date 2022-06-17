import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  // step 1
  FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // STEP 2
    AndroidInitializationSettings androidInti =
    AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosInti = IOSInitializationSettings();

    // STEP 3
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInti,
      iOS: iosInti,
    );

    tz.initializeTimeZones();

    // STEP 4
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectectNoti);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showNotification();
                },
                child: Text("Local"),
              ),
              ElevatedButton(
                onPressed: () {
                  shedualNotification();
                },
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                child: Text("Shedual Notification 5 Sec"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelectectNoti(String? payload) {}

  // STEP 5
  void showNotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Title",
        priority: Priority.high, importance: Importance.max);
    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.show(1, "Hiii NotiFication", "Testing",
        NotificationDetails(iOS: ios, android: and));
  }

  // STEP 6
  void shedualNotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Schedual",
        importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.zonedSchedule(
        1, "5 second", "Schedule Testing",tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: and, iOS: ios),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
