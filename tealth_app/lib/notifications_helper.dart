import 'package:flutter_local_notifications/flutter_local_notifications.dart'as notifs;
import 'package:rxdart/subjects.dart' as rxSub;

class NotificationClass{
  final int id;
  final String title;
  final String body;
  final String payload;
  NotificationClass({required this.id, required this.body, required this.payload, required this.title});
}

final rxSub.BehaviorSubject<NotificationClass> didReceiveLocalNotificationSubject =
rxSub.BehaviorSubject<NotificationClass>();
final rxSub.BehaviorSubject<String> selectNotificationSubject =
rxSub.BehaviorSubject<String>();

Future<void> initNotifications(
    notifs.FlutterLocalNotificationsPlugin
    notifsPlugin) async {
  var initializationSettingsAndroid = const notifs.AndroidInitializationSettings('mipmap/ic_launcher');
  var initializationSettingsIOS = const notifs.IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: null);
      // onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
      //   didReceiveLocalNotificationSubject.add(
      //       NotificationClass(id: id, title: title, body: body, payload: payload)
      //   );
      // }
  // );
  var initializationSettings = notifs.InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await notifsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      });

  print("Notifications initialised successfully");
}

void requestIOSPermissions(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin) {
  notifsPlugin.resolvePlatformSpecificImplementation<notifs.IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> scheduleNotification(
    {required notifs.FlutterLocalNotificationsPlugin notifsPlugin,
      required String id,
      required String title,
      required String body,
      required DateTime scheduledTime}) async {
  var androidSpecifics = notifs.AndroidNotificationDetails(
    id, // This specifies the ID of the Notification
    'Scheduled notification', // This specifies the name of the notification channel
    'A scheduled notification', //This specifies the description of the channel
    icon: 'mipmap/ic_launcher',
  );
  var iOSSpecifics = notifs.IOSNotificationDetails();
  var platformChannelSpecifics = notifs.NotificationDetails(
      android: androidSpecifics, iOS: iOSSpecifics);
  await notifsPlugin.schedule(0, title, "Scheduled notification",
      scheduledTime, platformChannelSpecifics); // This literally schedules the notification
}