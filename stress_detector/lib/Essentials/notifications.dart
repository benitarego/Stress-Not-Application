import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  FlutterLocalNotificationsPlugin fltrNotification;
  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('applogo');
    var initilizationsSettings =
    new InitializationSettings(android: androidInitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  _shownotification() async{
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Stress Not!", "You're tweeting hell lotta negative tweets! Calm down dude!", importance: Importance.max);
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    await fltrNotification.show(0, "Alert!", "You're tweeting hell lotta negative tweets! Calm down dude!", generalNotificationDetails);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RaisedButton(
            onPressed: _shownotification,
            child: Text('Flutter Notifications'),
          )
      ),
    );
  }

  Future notificationSelected(String payload) async {

  }
}
