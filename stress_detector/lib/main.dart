import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stress_detector/DashboardPage.dart';
import 'package:stress_detector/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stress Detector',
      home: new SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState() {
    _mockCheckForSession().then((status) {
      if (status) {
        FirebaseAuth.instance
            .currentUser()
            .then((currentUser) => {
          if (currentUser == null) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()
                )
            )
          }
          else {
            Firestore.instance
                .collection("Users")
                .document(currentUser.uid)
                .get()
                .then((DocumentSnapshot result) {
              print(currentUser.email);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardPage(
                        uid: currentUser.uid,
                      )));
            })
                .catchError((e) => print(e))
          }
        }).catchError((e) => print(e));
      } else {
        print('error');
      }
    });
    super.initState();
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }

  // void _navigateToLogin() {
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => LoginScreen()
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 1.0,
                  child: Image.asset('assets/applogo.png', width: 150.0, height: 150.0,),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.white30,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Stress Not!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'NotoSansHK'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
