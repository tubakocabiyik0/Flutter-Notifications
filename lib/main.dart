import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> Initialization() async {
    var forAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
    var forIos = IOSInitializationSettings();
    var init = InitializationSettings(forAndroid, forIos);
    await flp.initialize(init, onSelectNotification: choiseNotifications);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.deepPurple.shade100,
      debugShowCheckedModeBanner: false,
      home: homeWidget(),
    );
  }

  homeWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('Send Notification'),
                onPressed: () {
                  showNotification();
                }),RaisedButton(
                child: Text('Send Notification Late'),
                onPressed: () {
                  showNotificationWithTime();
                }),
          ],
        ),
      ),
    );
  }

  Future choiseNotifications(String payload) {
    if (payload != null) {}
  }

  Future<void> showNotification() async {
    var AndroidDetail = AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      priority: Priority.High,
      importance: Importance.High,
    );
    var Iosdetail = IOSNotificationDetails();
    var detail = NotificationDetails(AndroidDetail, Iosdetail);
    await flp.show(0, "Notification", "body", detail);
  }
  Future<void> showNotificationWithTime() async {
    var AndroidDetail = AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      priority: Priority.High,
      importance: Importance.High,
    );
    var Iosdetail = IOSNotificationDetails();
    var detail = NotificationDetails(AndroidDetail, Iosdetail);
    var time= DateTime.now().add(Duration(seconds: 5));
    await flp.schedule(0, "Notification Time", "body",time, detail);
  }
}
