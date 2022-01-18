import 'package:flutter/material.dart';
import 'package:work_manager_async/api_test/notification/notification_center.dart';
import 'package:workmanager/workmanager.dart';

const String tag = "BackGround_Work";

class BackGroundWorkSample extends StatefulWidget {
  const BackGroundWorkSample({Key? key}) : super(key: key);

  @override
  _BackGroundWorkSampleState createState() => _BackGroundWorkSampleState();
}

class _BackGroundWorkSampleState extends State<BackGroundWorkSample> {
  @override
  void initState() {
    super.initState();
    //This task runs periodically
    //It will wait at least 10 seconds before its first launch
    //Since we have not provided a frequency it will be the default 15 minutes
    Workmanager().registerPeriodicTask(
      tag,
      "simplePeriodicTask",
      initialDelay: const Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BackGround Work Sample'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    await NotificationCenter().pushNotification('1', 'Hi');
                  },
                  child: const Text('Create An Notification'))
            ],
          ),
        ));
  }
}
