import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/LoginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              twitterLogin.logOut().then((res) {
                print('Signed Out');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }).catchError((e) {
                print(e);
              });
              _auth.signOut();
            },
          )
        ],
      ),
      body: Center(
          child: Text('Get Started', style: TextStyle(color: kThemeColor, fontSize: 25),)
      ),
    );
  }
}
