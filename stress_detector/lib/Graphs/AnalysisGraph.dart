import 'package:flutter/material.dart';

class AnalysisGraph extends StatefulWidget {
  @override
  _AnalysisGraphState createState() => _AnalysisGraphState();
}

class _AnalysisGraphState extends State<AnalysisGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Analysis', style: TextStyle(fontSize: 25),),
      ),
    );
  }
}
