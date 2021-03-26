import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Graphs/Tweets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MonthlyGraph extends StatefulWidget {
  @override
  _MonthlyGraphState createState() => _MonthlyGraphState();
}

class _MonthlyGraphState extends State<MonthlyGraph> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Monthly Analysis', style: TextStyle(fontSize: 25),),
    );
  }
}
