import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MonthlyGraph extends StatefulWidget {
  @override
  _MonthlyGraphState createState() => _MonthlyGraphState();
}

class _MonthlyGraphState extends State<MonthlyGraph> {

  List<charts.Series<Tweets1, String>> _seriesData;
  // List<Tweets1> mydata, mydata1, mydata2;

  // var axis = charts.NumericAxisSpec(
  //     renderSpec: charts.GridlineRendererSpec(
  //       labelStyle: charts.TextStyleSpec(
  //           fontSize: 12, color: charts.MaterialPalette.white),
  //     ));

  _generateData() {
    var data1 = [
      new Tweets1(32, 'December', '0xff23931c'),
      new Tweets1(53, 'January', '0xff3e97ed'),
      new Tweets1(76, 'February', '0xfff75c40'),
      new Tweets1(57, 'March', '0xfff75c40'),
    ];

    var data2 = [
      new Tweets1(42, 'December', '0xff23931c'),
      new Tweets1(37, 'January', '0xff3e97ed'),
      new Tweets1(63, 'February', '0xfff75c40'),
      new Tweets1(31, 'March', '0xfff75c40'),
    ];
    var data3 = [
      new Tweets1(72, 'December', '0xff23931c'),
      new Tweets1(56, 'January', '0xff3e97ed'),
      new Tweets1(49, 'February', '0xfff75c40'),
      new Tweets1(68, 'March', '0xfff75c40'),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Tweets1 tweets1, _) => tweets1.statName,
        measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
        id: 'Tweet Analysis',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        // fillColorFn: (Tweets1 tweets1, _) =>
        //     charts.ColorUtil.fromDartColor(Color(0xff23931c)),
        measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
        measureUpperBoundFn: (Tweets1 tweets1, _) => 100,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff3ac758)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Tweets1 tweets1, _) => tweets1.statName,
        measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
        id: 'Tweet Analysis',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        // fillColorFn: (Tweets1 tweets1, _) =>
        //     charts.ColorUtil.fromDartColor(Color(0xff3e97ed)),
        measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
        measureUpperBoundFn: (Tweets1 tweets1, _) => 100,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff4782d6)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Tweets1 tweets1, _) => tweets1.statName,
        measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
        id: 'Tweet Analysis',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        // fillColorFn: (Tweets1 tweets1, _) =>
        //     charts.ColorUtil.fromDartColor(Color(0xffed3e3e)),
        measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
        measureUpperBoundFn: (Tweets1 tweets1, _) => 100,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xfff75c40)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData = List<charts.Series<Tweets1, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('Monthly Analysis', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
            buildChart(context)
          ],
        ),
      ),
    );
  }

  Widget buildChart(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      height: 380,
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
                  fontSize: 21.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Monthly Analysis',
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: charts.BarChart(
              _seriesData,
              animate: true,
              // primaryMeasureAxis: axis,
              barGroupingType: charts.BarGroupingType.grouped,
              behaviors: [
                new charts.DatumLegend(
                  entryTextStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.black,
                      fontFamily: 'Roboto',
                      fontSize: 10
                  ),
                )
              ] ?? '',
              animationDuration: Duration(seconds: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class Tweets1 {
  int statVal;
  String statName;
  String colorVal;

  Tweets1(this.statVal, this.statName,this.colorVal);

  Tweets1.fromMap(Map<String, dynamic> map)
      : assert(map['statVal'] != null),
        assert(map['statName'] != null),
        assert(map['colorVal'] != null),
        statVal = map['statVal'],
        colorVal = map['colorVal'],
        statName = map['statName'];

  @override
  String toString() => "Record<$statVal:$statName:$colorVal>";
}
