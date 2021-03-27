import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WeeklyGraph extends StatefulWidget {
  @override
  _WeeklyGraphState createState() => _WeeklyGraphState();
}

class _WeeklyGraphState extends State<WeeklyGraph> {

  List<charts.Series<Tweets1, String>> _seriesData;
  // List<Tweets1> mydata, mydata1, mydata2;

  _generateData() {
    var data1 = [
      new Tweets1(72, 'Week 1', '0xff23931c'),
      new Tweets1(41, 'Week 2', '0xff3e97ed'),
      new Tweets1(63, 'Week 3', '0xffed3e3e'),
      new Tweets1(46, 'Week 4', '0xffed3e3e'),
    ];

    var data2 = [
      new Tweets1(55, 'Week 1', '0xff23931c'),
      new Tweets1(60, 'Week 2', '0xff3e97ed'),
      new Tweets1(37, 'Week 3', '0xffed3e3e'),
      new Tweets1(68, 'Week 4', '0xffed3e3e'),
    ];
    var data3 = [
      new Tweets1(69, 'Week 1', '0xff23931c'),
      new Tweets1(36, 'Week 2', '0xff3e97ed'),
      new Tweets1(80, 'Week 3', '0xffed3e3e'),
      new Tweets1(34, 'Week 4', '0xffed3e3e'),
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
        measureUpperBoundFn: (Tweets1 tweets1, _) => 100,
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
            Text('Weekly Analysis', style: TextStyle(fontSize: 25),),
            buildChart(context)
          ],
        ),
      ),
    );
  }

  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance.collection('tweets').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return CircularProgressIndicator();
  //       } else {
  //         List<Tweets> tweets = snapshot.data.documents
  //             .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
  //             .toList();
  //         return _buildChart(context, tweets);
  //       }
  //     },
  //   );
  // }
  //
  // Widget _buildChart(BuildContext context, List<Tweets> tweetdata) {
  //   mydata = tweetdata;
  //   _generateData(mydata);
  //   return Container(
  //       padding: EdgeInsets.all(16),
  //       margin: const EdgeInsets.all(10),
  //       height: 350,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(18),
  //           // border: Border.all(color: Colors.black)
  //           color: Colors.black
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: <Widget>[
  //           Padding(
  //             padding: EdgeInsets.only(left: 10),
  //             child: Text('Tweet Analysis',
  //               style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
  //             ),
  //           ),
  //           SizedBox(height: 5,),
  //           Padding(
  //             padding: EdgeInsets.only(left: 10),
  //             child: Text('Daily Analysis',
  //               style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.grey),
  //             ),
  //           ),
  //           SizedBox(height: 5,),
  //           Expanded(
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 8),
  //                 child: charts.BarChart(
  //                     _seriesBarData,
  //                     animate: true,
  //                     animationDuration: Duration(seconds:5),
  //                     barGroupingType: charts.BarGroupingType.grouped,
  //                     behaviors: [
  //                       new charts.DatumLegend(
  //                         entryTextStyle: charts.TextStyleSpec(
  //                             color: charts.MaterialPalette.white,
  //                             fontFamily: 'Roboto',
  //                             fontSize: 18),
  //                       )
  //                     ] ?? ''
  //                 ),
  //               )
  //           ),
  //         ],
  //       ) ?? ''
  //   );
  // }

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
            child: Text('Weekly Analysis',
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
                    fontSize: 12
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

