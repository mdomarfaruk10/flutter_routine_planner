import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationHelper{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  initializationNotificatio()async{
    tz.initializeTimeZones();
    final AndroidInitializationSettings initializationSettingsandroid=
    AndroidInitializationSettings('mipmap/ic_launcher');

    final InitializationSettings initializationSettings=
    InitializationSettings(
      iOS: null,
      android: initializationSettingsandroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,

      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {

      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }


  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  scheduleNotification()async{

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "schedule title",
        "schedule body",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 6)),
        const NotificationDetails(
          android: AndroidNotificationDetails("notififcation channel", "notificaiton body")
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      // matchDateTimeComponents: DateTimeComponents.time
    );
  }

}