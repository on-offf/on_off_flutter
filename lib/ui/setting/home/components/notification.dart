import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification() async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}

//2. 알림들
dailyWriteNotification(String message, int hour, int min) async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    'everyday-write-alarm', //유니크한 알림 채널 ID
    '매일 글쓰는 시간 알림', //알림 종류 설명
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );
  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.zonedSchedule(
    2, //id
    '온앤오프 - on & off', //title
    message, //내용
    makeDate(hour, min),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

removeWriteNotification() {
  notifications.cancel(2);
}

makeDate(hour, min) {
  var now = tz.TZDateTime.now(tz.local);
  var when = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, hour, min, 0);
  return when;
}
