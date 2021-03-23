import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WeeklyGraph extends StatefulWidget {
  @override
  _WeeklyGraphState createState() => _WeeklyGraphState();
}

class _WeeklyGraphState extends State<WeeklyGraph> {

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

  @override
  Widget build(BuildContext context) {
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
}
