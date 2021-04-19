import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:stress_detector/Pages/HomePage.dart';
import 'package:stress_detector/Pages/ProfilePage.dart';
import 'package:stress_detector/Pages/AnalyticsPage.dart';
import 'package:stress_detector/Pages/RecommendationsPage.dart';

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
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30,),
            activeIcon: Icon(Icons.home, size: 30,),
            title: Container(),
            // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined, size: 30,),
              activeIcon: Icon(Icons.analytics, size: 30,),
              title: Container(),
              // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined, size: 30,),
              activeIcon: Icon(Icons.star, size: 30,),
              title: Container(),
              // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 30,),
              activeIcon: Icon(Icons.person, size: 30,),
              title: Container(),
              // backgroundColor: Colors.grey
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
      //   backgroundColor: Colors.transparent,
      //   buttonBackgroundColor: kThemeColor,
      //   height: 50,
      //   items: <Widget>[
      //     Icon(Icons.home, color: Colors.white,),
      //     Icon(Icons.bar_chart, color: Colors.white,),
      //     Icon(Icons.star, color: Colors.white,),
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


