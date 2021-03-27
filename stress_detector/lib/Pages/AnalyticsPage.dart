import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/Graphs/AnalysisGraph.dart';
import 'package:stress_detector/Graphs/MonthlyGraph.dart';
import 'package:stress_detector/Graphs/WeeklyGraph.dart';
import 'package:stress_detector/Graphs/DailyGraph.dart';
import 'package:stress_detector/LoginPage.dart';

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
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 25,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              twitterLogin.logOut().then((res) {
                print('Signed Out');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }).catchError((e) {
                print(e);
              });
              _auth.signOut();
            },
          )
        ],
      ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfff8f5f5),
                        border: Border.all(color: Colors.grey),
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
                          dropdownColor: Color(0xfff8f5f5),
                          elevation: 5,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                        ),
                      )
                    )
                ),
                Center(
                    child: _showgraph
                ),
                // _buildBody(context),
              ],
            ),
          ),
        )
    );
  }
}
