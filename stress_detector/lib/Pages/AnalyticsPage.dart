import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:stress_detector/Graphs/DailyGraph.dart';
import 'package:stress_detector/Graphs/WeeklyGraph.dart';
import 'package:stress_detector/Graphs/MonthlyGraph.dart';


class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() {
    return _AnalyticsPageState();
  }
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '08OK5WCBZOikvduhRawVdd4so',
      consumerSecret: 'WW9foP5mqpJ886x4AR1HZmemKGpmz7SO3HppLRZT1p4YVFE7ry'
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
        return MonthlyGraph();
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
  // List _statistics = ['Daily', 'Weekly', 'Monthly', 'Analysis'];

  List<DropdownMenuItem<String>> _statsitem() {
    List<String> _statistics = ["Daily", "Weekly", "Monthly", "Analysis"];
    return _statistics.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Analytics", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
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
                  child: DropdownButton(
                      hint: Text("Daily"),
                      value: _statisticsVal,
                      items: _statsitem(),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          _statisticsVal = value;
                          _showgraph = _graphChooser(value);
                        });
                        // switch(value){
                        //   case "Daily" :
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => DailyGraph()),
                        //     );
                        //     break;
                        //   case "Weekly" :
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => WeeklyGraph()),
                        //     );
                        //     break;
                        //   case "Monthly" :
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => MonthlyGraph()),
                        //     );
                        //     break;
                        //   case "Analysis" :
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => MonthlyGraph()),
                        //     );
                        //     break;
                        //   }
                      },
                      dropdownColor: Color(0xfff8f5f5),
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                    ),
                )
              ),
              // RaisedButton(
              //     onPressed: () {
              //       setState(() {
              //
              //       });
              //     },
              //     child: Text('Click me')
              // ),
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
