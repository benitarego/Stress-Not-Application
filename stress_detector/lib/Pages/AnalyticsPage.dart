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
import 'package:flutter/services.dart';
import 'package:whatsapp_share/whatsapp_share.dart';


class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '9b8smdO0UloxZojzQ3Eh4zR7e',
      consumerSecret: 'MhmYPAiSSeoThxzvGtpSfwEQKuklKbDkQeen9q2Wrsb9bJjhJL'
  );

  Future<void> share() async {
    await WhatsappShare.share(
      text: "You're giving negative vibes bitch!",
      linkUrl: 'https://flutter.dev/',
      phone: '919892938847',
    );
  }

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
          share();
          // FOR SMS
          // client.messages.create({
          //   body: 'Hello there!!! Welcome aboard....Stay tuned.',
          //   to: ‘+919892938847’,
          //   from: ‘+14155238886,
          // })
          //FOR WHATSAPP
          // client.messages
          //     .create({
          //   body: 'Hello newbie..Welcome aboard!!!! Learn more at: http://flatteredwithflutter.com/',
          //   from: 'whatsapp: +14155238886’,
          //   to: 'whatsapp: +919892938847’
          // })
        },
      ),
    );
  }
}
