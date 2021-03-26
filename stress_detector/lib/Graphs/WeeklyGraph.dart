import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WeeklyGraph extends StatefulWidget {
  @override
  _WeeklyGraphState createState() => _WeeklyGraphState();
}

class _WeeklyGraphState extends State<WeeklyGraph> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            // _buildBody1(context),
            Text('Weekly Analysis', style: TextStyle(fontSize: 25),)
          ],
        ),
      ),
    );
  }

  // Widget _buildBody1(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance.collection('tweets').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return CircularProgressIndicator();
  //       } else {
  //         List<Tweets> tweets = snapshot.data.documents
  //             .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
  //             .toList();
  //         return _buildChart1(context, tweets);
  //       }
  //     },
  //   );
  // }
  //
  // Widget _buildChart1(BuildContext context, List<Tweets> tweetdata) {
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

// Widget build(BuildContext context) {
//     // return SingleChildScrollView(
//     //   child: Container(
//     //     child: Column(
//     //       children: <Widget>[
//     //         // Padding(
//     //         //   padding: EdgeInsets.all(8.0),
//     //         //   child: Container(
//     //         //     child: Center(
//     //         //       child: Column(
//     //         //         children: <Widget>[
//     //         //           Text(
//     //         //             'SO₂ emissions, by world region (in million tonnes)',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
//     //         //           Expanded(
//     //         //             child: charts.BarChart(
//     //         //               _seriesData,
//     //         //               animate: true,
//     //         //               barGroupingType: charts.BarGroupingType.grouped,
//     //         //               //behaviors: [new charts.SeriesLegend()],
//     //         //               animationDuration: Duration(seconds: 5),
//     //         //             ),
//     //         //           ),
//     //         //         ],
//     //         //       ),
//     //         //     ),
//     //         //   ),
//     //         // ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//     // return StreamBuilder<QuerySnapshot>(
//     //   stream: Firestore.instance.collection('tweets').snapshots(),
//     //   builder: (context, snapshot) {
//     //     if (!snapshot.hasData) {
//     //       return CircularProgressIndicator();
//     //     } else {
//     //       List<Tweets> tweets = snapshot.data.documents
//     //           .map((documentSnapshot) => Tweets.fromMap(documentSnapshot.data))
//     //           .toList();
//     //       return _buildChart(context, tweets);
//     //     }
//     //   },
//     // );
//   }
}

