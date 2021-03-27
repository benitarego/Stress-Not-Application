import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyGraph extends StatefulWidget {
  @override
  _DailyGraphState createState() => _DailyGraphState();
}

class _DailyGraphState extends State<DailyGraph> {

  List<charts.Series<Tweets, String>> _seriesBarData, _seriesPieData;
  List<Tweets> mydata;

  _generateData(mydata) {
    //BAR GRAPH
    _seriesBarData = List<charts.Series<Tweets, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Tweets tweets, _) => tweets.statName.toString(),
        measureFn: (Tweets tweets, _) => tweets.statVal,
        measureLowerBoundFn: (Tweets tweets, _) => tweets.statVal,
        measureUpperBoundFn: (Tweets tweets, _) => 100,
        colorFn: (Tweets tweets, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(tweets.colorVal))),
        id: 'Tweet Analysis',
        data: mydata,
        labelAccessorFn: (Tweets row, _) => "${row.statName}",
      ),
    );

    //PIE CHART
    _seriesPieData = List<charts.Series<Tweets, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Tweets tweets, _) => tweets.statName,
        measureFn: (Tweets tweets, _) => tweets.statVal,
        colorFn: (Tweets tweets, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(tweets.colorVal))),
        id: 'Tweet Analysis',
        data: mydata,
        labelAccessorFn: (Tweets row, _) => "${row.statVal}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('Daily Analysis', style: TextStyle(fontSize: 25),),
            _buildBody1(context),
            _buildBody2(context),
          ],
        ),
      ),
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

  Widget _buildChart1(BuildContext context, List<Tweets> tweetdata) {
    mydata = tweetdata;
    _generateData(mydata);
    return Container(
        padding: EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black),
            color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Tweet Analysis',
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Daily Analysis',
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: charts.BarChart(
                      _seriesBarData,
                      animate: true,
                      animationDuration: Duration(seconds:1),
                      behaviors: [
                        new charts.DatumLegend(
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.black,
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

  Widget _buildBody2(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tweets').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Tweets> tweets = snapshot.data.documents
              .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart2(context, tweets);
        }
      },
    );
  }

  Widget _buildChart2(BuildContext context, List<Tweets> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          height: 365,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black),
              color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25, top: 15),
                child: Text('Tweet Analysis',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('Daily Analysis',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 290,
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 3),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                        new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.black,
                            fontFamily: 'Roboto',
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        )
    );
  }
}