import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalysisGraph extends StatefulWidget {
  @override
  _AnalysisGraphState createState() => _AnalysisGraphState();
}

class _AnalysisGraphState extends State<AnalysisGraph> {
  List<charts.Series<Tweets2, int>> _seriesData1, _seriesData2, _seriesData3;

  _generateData1() {
    final data1 = [
      new Tweets2(0, 5),
      new Tweets2(1, 23),
      new Tweets2(2, 34),
      new Tweets2(3, 57),
    ];

    _seriesData1.add(
      charts.Series(
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Tweets2 tweets2, _) => tweets2.statName,
        measureFn: (Tweets2 tweets2, _) => tweets2.value,
        measureLowerBoundFn: (Tweets2 tweets2, _) => tweets2.value,
        measureUpperBoundFn: (Tweets2 tweets2, _) => 100,
        data: data1,
      ),
    );
  }

  _generateData2() {
    final data2 = [
      new Tweets2(0, 7),
      new Tweets2(1, 10),
      new Tweets2(2, 33),
      new Tweets2(3, 52),
    ];

    _seriesData2.add(
      charts.Series(
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Tweets2 tweets2, _) => tweets2.statName,
        measureFn: (Tweets2 tweets2, _) => tweets2.value,
        data: data2,
        measureLowerBoundFn: (Tweets2 tweets2, _) => tweets2.value,
        measureUpperBoundFn: (Tweets2 tweets2, _) => 100,
      ),
    );
  }

  _generateData3() {
    final data3 = [
      new Tweets2(0, 3),
      new Tweets2(1, 10),
      new Tweets2(2, 11),
      new Tweets2(3, 20),
    ];

    _seriesData3.add(
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Tweets2 tweets2, _) => tweets2.statName,
        measureFn: (Tweets2 tweets2, _) => tweets2.value,
        data: data3,
        measureLowerBoundFn: (Tweets2 tweets2, _) => tweets2.value,
        measureUpperBoundFn: (Tweets2 tweets2, _) => 100,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData1 = List<charts.Series<Tweets2, int>>();
    _seriesData2 = List<charts.Series<Tweets2, int>>();
    _seriesData3 = List<charts.Series<Tweets2, int>>();
    _generateData1();
    _generateData2();
    _generateData3();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('Analysis', style: TextStyle(fontSize: 25),),
            buildChart1(context),
            buildChart2(context),
            buildChart3(context),
          ],
        ),
      ),
    );
  }

  Widget buildChart1(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      height: 250,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    backgroundColor: Colors.green,
                    label: Text('Positive', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: charts.LineChart(
                  _seriesData1,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                ),
            )
          ]
      ),
    );
  }

  Widget buildChart2(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      height: 250,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    backgroundColor: Colors.blue,
                    label: Text('Neutral', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: charts.LineChart(
                _seriesData2,
                animate: true,
                animationDuration: Duration(seconds: 1),
              ),
            )
          ]
      ),
    );
  }

  Widget buildChart3(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      height: 250,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chip(
                    backgroundColor: Colors.red,
                    label: Text('Negative', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: charts.LineChart(
                _seriesData3,
                animate: true,
                animationDuration: Duration(seconds: 1),
              ),
            )
          ]
      ),
    );
  }
}

class Tweets2 {
  int statName;
  int value;

  Tweets2(this.statName, this.value);

  Tweets2.fromMap(Map<int, dynamic> map)
      : assert(map['statName'] != null),
        assert(map['value'] != null),
        value = map['value'],
        statName = map['statName'];

  @override
  String toString() => "Record<$statName:$value>";
}

