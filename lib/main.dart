// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, constant_identifier_names

import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:work_manager_async/api_test/model/controller/album_controller.dart';
import 'package:workmanager/workmanager.dart';
import 'api_test/notification/notification_center.dart';

const String TAG = "BackGround_Work";

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

class MyApp extends StatelessWidget {
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

class BackGroundWorkSample extends StatefulWidget {
  @override
  _BackGroundWorkSampleState createState() => _BackGroundWorkSampleState();
}

class _BackGroundWorkSampleState extends State<BackGroundWorkSample> {
  int _counterValue = 0;

  @override
  void initState() {
    super.initState();
    //This task runs periodically
    //It will wait at least 10 seconds before its first launch
    //Since we have not provided a frequency it will be the default 15 minutes
    Workmanager().registerPeriodicTask(
      TAG,
      "simplePeriodicTask",
      initialDelay: Duration(seconds: 10),
    );
    loalData();
  }

  void loalData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BackGround Work Sample'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    await NotificationCenter().pushNotification();
                  },
                  child: Text('Create Notification'))
            ],
          ),
        ));
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var album = await AlbumControlleer().fetchAlbum();
    await NotificationCenter().pushNotification();
    print(album.id.toString() +
        ' ' +
        album.title +
        ' ' +
        album.userId.toString());
    return Future.value(true);
  });
}

// class BackGroundWork {
//   BackGroundWork._privateConstructor();

//   static final BackGroundWork _instance = BackGroundWork._privateConstructor();

//   static BackGroundWork get instance => _instance;

//   // _loadCounterValue(int value) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   await prefs.setInt('BackGroundCounterValue', value);
//   // }

//   // Future<int> _getBackGroundCounterValue() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   //Return bool
//   //   int counterValue = prefs.getInt('BackGroundCounterValue') ?? 0;
//   //   print('getted value ${counterValue}');
//   //   return counterValue;
//   // }
// }
