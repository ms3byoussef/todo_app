// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// class NotifyHelper {
//   tz.initializeTimeZones();
//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   tz.setLocalLocation(tz.getLocation(timeZoneName));
  
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('assets/icons/check.png');
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//     onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//   );
//   final MacOSInitializationSettings initializationSettingsMacOS =
//       const MacOSInitializationSettings(
//           requestAlertPermission: false,
//           requestBadgePermission: false,
//           requestSoundPermission: false);
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: onSelectNotification);

// void selectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     await Navigator.of(context);
  
// }

//       static AndroidNotificationDetails androidPlatformChannelSpecifics =
//     const AndroidNotificationDetails('your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
// static const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
// await flutterLocalNotificationsPlugin.show(
//     0, 'plain title', 'plain body', platformChannelSpecifics,
//     payload: 'item x');


//   void onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//    return showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text(title),
//         content: Text(body),
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondScreen(payload),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
