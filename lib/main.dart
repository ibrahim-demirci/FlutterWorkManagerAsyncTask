// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, constant_identifier_names

import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'api_test/controller/album_controller.dart';
import 'api_test/notification/notification_center.dart';
import 'api_test/view/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // This should be false
      );
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(MyApp());
}

// Execute every 15 minute.
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var album = await AlbumControlleer().fetchAlbum();
    await NotificationCenter()
        .pushNotification(album.id.toString(), album.title);
    print(album.id.toString() +
        ' ' +
        album.title +
        ' ' +
        album.userId.toString());
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BackGround Work Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BackGroundWorkSample(),
    );
  }
}
