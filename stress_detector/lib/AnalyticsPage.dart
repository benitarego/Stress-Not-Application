import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<charts.Series<Tweets, String>> _seriesBarData;
  List<Tweets> mydata;

  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Tweets, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Tweets tweets, _) => tweets.statName.toString(),
        measureFn: (Tweets tweets, _) => tweets.statVal,
        colorFn: (Tweets tweets, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(tweets.colorVal))),
        id: 'Tweet Analysis',
        data: mydata,
        labelAccessorFn: (Tweets row, _) => "${row.statName}",
      ),
    );
  }

  Widget _showgraph = new DailyGraph();

  Widget _graphChooser(int graph) {
    switch (graph) {
      case 0:
        return DailyGraph();
        break;
      case 1:
        return WeeklyGraph();
        break;
      case 2:
        return MonthlyGraph();
        break;
      case 3:
        return DailyGraph();
        break;
      case 4:
        return WeeklyGraph();
        break;
      case 5:
        return MonthlyGraph();
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text('No stats found', style: TextStyle(fontSize: 30),),
          ),
        );
    }
  }

  String _statisticsVal;
  List _statistics = ['Daily', 'Weekly', 'Monthly', 'Positive', 'Negative', 'Neutral'];

  @override
  void initState() {
    super.initState();
    _statisticsVal = _statistics[0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Daily"),
                      value: _statisticsVal,
                      dropdownColor: Color(0xfff8f5f5),
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _statisticsVal = value;
                          // _showgraph = _graphChooser(value);
                        });
                      },
                      items: _statistics.map((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value)
                        );
                      }).toList(),
                    ),
                  ),
                )
              ),
              Center(
                child: _showgraph,
              ),
              _buildBody(context),
              _buildBody1(context),
              _buildBody2(context),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tweets').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          List<Tweets> tweets = snapshot.data.documents
              .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, tweets);
        }
      },
    );
  }

  Widget _buildBody1(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tweets').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          List<Tweets> tweets = snapshot.data.documents
              .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart1(context, tweets);
        }
      },
    );
  }

  Widget _buildBody2(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tweets').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          List<Tweets> tweets = snapshot.data.documents
              .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart2(context, tweets);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Tweets> tweetdata) {
    mydata = tweetdata;
    _generateData(mydata);
    return Container(
        padding: EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.black
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Tweet Analysis',
                style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Weekly Analysis',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: charts.BarChart(
                      _seriesBarData,
                      animate: true,
                      animationDuration: Duration(seconds:5),
                      behaviors: [
                        new charts.DatumLegend(
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.white,
                              fontFamily: 'Roboto',
                              fontSize: 18),
                        )
                      ] ?? ''
                  ),
                )
            ),
          ],
        ) ?? ''
    );
  }

  Widget _buildChart1(BuildContext context, List<Tweets> tweetdata) {
    mydata = tweetdata;
    _generateData(mydata);
    return Container(
        padding: EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.black
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Tweet Analysis',
                style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Weekly Analysis',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: charts.BarChart(
                      _seriesBarData,
                      animate: true,
                      animationDuration: Duration(seconds:5),
                      behaviors: [
                        new charts.DatumLegend(
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.white,
                              fontFamily: 'Roboto',
                              fontSize: 18),
                        )
                      ] ?? ''
                  ),
                )
            ),
          ],
        ) ?? ''
    );
  }

  Widget _buildChart2(BuildContext context, List<Tweets> tweetdata) {
    mydata = tweetdata;
    _generateData(mydata);
    return Container(
        padding: EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.black
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Tweet Analysis',
                style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Weekly Analysis',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: charts.BarChart(
                      _seriesBarData,
                      animate: true,
                      animationDuration: Duration(seconds:5),
                      behaviors: [
                        new charts.DatumLegend(
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.white,
                              fontFamily: 'Roboto',
                              fontSize: 18),
                        )
                      ] ?? ''
                  ),
                )
            ),
          ],
        ) ?? ''
    );
  }
}
