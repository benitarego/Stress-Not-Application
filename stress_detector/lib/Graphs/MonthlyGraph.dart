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

  _generateData() {
    var data1 = [
      new Tweets1(3, 'December', '0xff23931c'),
      new Tweets1(5, 'January', '0xff3e97ed'),
      new Tweets1(7, 'February', '0xffed3e3e'),
      new Tweets1(5, 'March', '0xffed3e3e'),
    ];

    var data2 = [
      new Tweets1(4, 'December', '0xff23931c'),
      new Tweets1(3, 'January', '0xff3e97ed'),
      new Tweets1(6, 'February', '0xffed3e3e'),
      new Tweets1(3, 'March', '0xffed3e3e'),
    ];
    var data3 = [
      new Tweets1(7, 'December', '0xff23931c'),
      new Tweets1(5, 'January', '0xff3e97ed'),
      new Tweets1(4, 'February', '0xffed3e3e'),
      new Tweets1(6, 'March', '0xffed3e3e'),
    ];
    // _seriesData.add(
    //   charts.Series(
    //     domainFn: (Tweets1 tweets1, _) => tweets1.statName.toString(),
    //     measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     colorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //     id: 'Tweet Analysis',
    //     data: data1,
    //     labelAccessorFn: (Tweets1 row, _) => "${row.statName}",
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //   ),
    // );
    // _seriesData.add(
    //   charts.Series(
    //     domainFn: (Tweets1 tweets1, _) => tweets1.statName.toString(),
    //     measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     colorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //     id: 'Tweet Analysis',
    //     data: data2,
    //     labelAccessorFn: (Tweets1 row, _) => "${row.statName}",
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //   ),
    // );
    // _seriesData.add(
    //   charts.Series(
    //     domainFn: (Tweets1 tweets1, _) => tweets1.statName.toString(),
    //     measureFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureLowerBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal,
    //     colorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //     id: 'Tweet Analysis',
    //     data: data3,
    //     labelAccessorFn: (Tweets1 row, _) => "${row.statName}",
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Tweets1 tweets1, _) =>
    //         charts.ColorUtil.fromDartColor(Color(int.parse(tweets1.colorVal))),
    //   ),
    // );

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
        measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal + 2,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff23931c)),
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
        measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal + 2,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff3e97ed)),
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
        measureUpperBoundFn: (Tweets1 tweets1, _) => tweets1.statVal + 2,
        colorFn: (Tweets1 tweets1, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffed3e3e)),
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
            Text('Monthly Analysis', style: TextStyle(fontSize: 25),),
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
            child: Text('Monthly Analysis',
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
            child: charts.BarChart(
              _seriesData,
              animate: true,
              barGroupingType: charts.BarGroupingType.grouped,
              behaviors: [
                new charts.DatumLegend(
                  entryTextStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.black,
                      fontFamily: 'Roboto',
                      fontSize: 14
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
