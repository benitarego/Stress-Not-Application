import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/AnalyticsPage.dart';
import 'package:stress_detector/HomePage.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:stress_detector/ProfilePage.dart';
import 'package:stress_detector/RecommendationsPage.dart';
import 'package:stress_detector/ThemeColor.dart';
import 'package:stress_detector/Loading.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardPage extends StatefulWidget {
  String uid;
  DashboardPage({Key key, this.uid}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String,dynamic> theuser;
  FirebaseUser currentUser;
  @override
  void initState() {
    Firestore.instance.collection('Users').document(widget.uid).get().then((value) {
      print(value.data);
      theuser = value.data;
    });
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '08OK5WCBZOikvduhRawVdd4so',
      consumerSecret: 'WW9foP5mqpJ886x4AR1HZmemKGpmz7SO3HppLRZT1p4YVFE7ry'
  );

  void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token,
        authTokenSecret: secret
    );
    await _auth.signInWithCredential(credential);
    print('Login done');
  }

  final GlobalKey<ScaffoldState>_scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return HomePage();
        break;
      case 1:
        return AnalyticsPage();
        break;
      case 2:
        return PlacesSearchMapSample();
        break;
      case 3:
        return ProfilePage();
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text('No page found', style: TextStyle(fontSize: 30),),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              title: Text('Analytics'),
              backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Recommendation'),
              backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor: Colors.grey
          ),
        ],
        onTap: (int tappedIndex) {
          setState(() {
            _currentIndex = tappedIndex;
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   color: Colors.black,
      //   backgroundColor: Colors.white,
      //   buttonBackgroundColor: kThemeColor,
      //   height: 50,
      //   items: <Widget>[
      //     Icon(Icons.home, color: Colors.white,),
      //     Icon(Icons.bar_chart, color: Colors.white,),
      //     Icon(Icons.star, color: Colors.white,),
      //     Icon(Icons.person, color: Colors.white,),
      //   ],
      //   animationDuration: Duration(milliseconds: 400),
      //   onTap: (int tappedIndex) {
      //     setState(() {
      //       _showPage = _pageChooser(tappedIndex);
      //     });
      //   },
      // ),
    );
  }
}


