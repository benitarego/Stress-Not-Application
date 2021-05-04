import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:stress_detector/Essentials/FadeAnimation.dart';
import 'package:stress_detector/Graphs/AnalysisGraph.dart';
import 'package:stress_detector/Graphs/MonthlyGraph.dart';
import 'package:stress_detector/Graphs/WeeklyGraph.dart';
import 'package:stress_detector/Graphs/DailyGraph.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '4xHhtirZfM5ejlT5ecQKVGhgv',
      consumerSecret: 'iVkSlSYKQHCTYKls57cbKd9yPQJVup3f35LgMT8ZekTnAz5hlZ'
  );

  TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid : 'AC46744f84e5ec287ffc39390bea20101d', // replace ** with Account SID
    authToken : '356d8e8dc5d965a31288b83cb1ed3de2',  // replace xxx with Auth Token
    twilioNumber : '+14155238886'  // replace .... with Twilio Number
  );

  Widget _showgraph = new DailyGraph();

  Widget _graphChooser(String graph) {
    switch (graph) {
      case "Daily":
        return DailyGraph();
        break;
      case "Weekly":
        return WeeklyGraph();
        break;
      case "Monthly":
        return MonthlyGraph();
        break;
      case "Analysis":
        return AnalysisGraph();
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text('No graph found', style: TextStyle(fontSize: 30),),
          ),
        );
    }
  }

  String _statisticsVal = "Daily";

  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var initilizationsSettings =
    new InitializationSettings(android: androidInitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
  }

  _shownotification() async{
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Stress Not!", "You're tweeting hell lotta negative tweets! Calm down dude!", importance: Importance.max);
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    await fltrNotification.show(0, "Alert!", "Lots of negativity tweeted on Twitter!\nCheck analysis.", generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: kThemeColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 25,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              twitterLogin.logOut().then((res) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }).catchError((e) {
                print(e);
              });
              FirebaseAuth.instance.signOut();
              print('Signed Out');
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)
                        )
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 5),
                      child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Daily"),
                              value: _statisticsVal,
                              items: <String>['Daily', 'Weekly', 'Monthly', 'Analysis']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _statisticsVal = value;
                                  _showgraph = _graphChooser(value);
                                });
                              },
                              dropdownColor: Colors.white,
                              elevation: 5,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                              isExpanded: true,
                            ),
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 90),
                    child: FadeAnimation(0.7,
                        Center(
                          child: _showgraph
                    )
                    )
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kThemeColor,
        tooltip: 'Send SMS',
        child: Icon(Icons.send),
        onPressed: () {
          twilioFlutter.sendWhatsApp(
              toNumber : '+919892938847',
              messageBody : 'Hey! You seem to be having a declining mental state! Kindly check for nearby consultation firms on our application, if necessary. Regards, Stress Not! Team');
          // _shownotification();
          print('clicked');
        },

      ),
    );
  }
}
