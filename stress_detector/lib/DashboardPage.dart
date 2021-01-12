import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/ThemeColor.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'IXo5uEathVAM3NIQcsYTioDTY',
      consumerSecret: 'rSfXe1a3Qk1V9B3DSrbcVJZrH402FLWvjsbiFQ9BvJ0MxWMJV6'
  );

  void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token,
        authTokenSecret: secret
    );
    await _auth.signInWithCredential(credential);
    print('Login done');
  }

  _logout() async {
    await twitterLogin.logOut();
    await _auth.signOut();
    print('Logged out successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Dashboard", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          FirebaseUser firebaseUser = snapshot.data;
          return snapshot.hasData
              ? Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Stress Not!",
                      style: TextStyle(
                        color: kThemeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    firebaseUser.photoUrl == null
                        ? SizedBox(height: 0)
                        : Image.network(firebaseUser.photoUrl, height: 100),
                    Text("Name: ${firebaseUser.displayName}", style: TextStyle(fontSize: 16),),
                    SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: () {
                        _logout();
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    )
                  ],
                ),
              )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
