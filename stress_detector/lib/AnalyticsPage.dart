import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:stress_detector/ThemeColor.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/LoginPage.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() {
    return _AnalyticsPageState();
  }
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'IXo5uEathVAM3NIQcsYTioDTY',
      consumerSecret: 'rSfXe1a3Qk1V9B3DSrbcVJZrH402FLWvjsbiFQ9BvJ0MxWMJV6'
  );

  void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token,
        authTokenSecret: secret
    );
    await _auth.signInWithCredential(credential);
    print('Login done');
  }

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

  String _statisticsVal;
  List _statistics = ['Daily', 'Weekly', 'Monthly', 'Positive', 'Negative', 'Neutral'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          RaisedButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
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
            child: Text(
              "Logout",
              style: TextStyle(color: kThemeColor),
            ),
            color: Colors.black,
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

  Widget _buildChart(BuildContext context, List<Tweets> saledata) {
    mydata = saledata;
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
            Text('Tweet Analysis',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            // SizedBox(height: 4),
            // Text('Weekly Analysis',
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey),
            // ),
            SizedBox(height: 25.0,),
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
                              fontFamily: 'Georgia',
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

  Widget _buildChart1(BuildContext context, List<Tweets> saledata) {
    mydata = saledata;
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
            Text('Tweet Analysis',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            // SizedBox(height: 4),
            // Text('Weekly Analysis',
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey),
            // ),
            SizedBox(height: 25.0,),
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
                              fontFamily: 'Georgia',
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

  Widget _buildChart2(BuildContext context, List<Tweets> saledata) {
    mydata = saledata;
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
            Text('Tweet Analysis',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            // SizedBox(height: 4),
            // Text('Weekly Analysis',
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey),
            // ),
            SizedBox(height: 25.0,),
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
                              fontFamily: 'Georgia',
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

class Tweets {
  final int statVal;
  final String statName;
  final String colorVal;
  Tweets(this.statVal, this.statName,this.colorVal);

  Tweets.fromMap(Map<String, dynamic> map)
      : assert(map['statVal'] != null),
        assert(map['statName'] != null),
        assert(map['colorVal'] != null),
        statVal = map['statVal'],
        colorVal = map['colorVal'],
        statName = map['statName'];

  @override
  String toString() => "Record<$statVal:$statName:$colorVal>";
}