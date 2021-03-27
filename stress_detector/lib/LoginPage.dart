import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/DashboardPage.dart';
import 'package:stress_detector/Essentials/FadeAnimation.dart';
import 'package:stress_detector/Essentials/Loading.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return DashboardPage();
          } else if (userSnapshot.hasError) {
            return CircularProgressIndicator();
          }
          return LoginScreen();
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  // final String uid;
  // LoginScreen({Key key, this.uid}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  String message;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 80.0,),
                    FadeAnimation(0.4,
                      Image.asset('assets/applogo.png', width: 90.0, height: 90.0,),
                    ),
                    SizedBox(height: 20.0,),
                    FadeAnimation(0.6,
                      Text('Welcome to Stress Not!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 27.0,
                            color: kThemeColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    FadeAnimation(0.8,
                      Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Text('Real time Twitter monitoring tool for mental health analysis and evaluation.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 30.0,),
                    FadeAnimation(1.0, InkWell(
                      onTap: () {
                        login();
                      },
                      borderRadius: BorderRadius.circular(30),
                      splashColor: kThemeColor,
                      child: Container(
                        height: 50,
                        width: 300,
                        padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                        ),
                        child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/twitter.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: 20,),
                              Text(
                                'Sign In with Twitter',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),
                              ),
                            ],
                          ),
                      ),
                    )),
                    SizedBox(height: 20),
                    Text(
                      message == null ? "" : message,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      )
    );
  }

  void login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;
    if (result.status == TwitterLoginStatus.loggedIn) {
      _signInWithTwitter(result.session.token, result.session.secret);
      print('Logged in successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      newMessage = 'Login cancelled by user.';
    } else {
      newMessage = result.errorMessage;
    }
    setState(() {
      message = newMessage;
    });
  }
}

FirebaseAuth _auth = FirebaseAuth.instance;

final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '9b8smdO0UloxZojzQ3Eh4zR7e',
    consumerSecret: 'MhmYPAiSSeoThxzvGtpSfwEQKuklKbDkQeen9q2Wrsb9bJjhJL'
);

void _signInWithTwitter(String token, String secret) async {
  final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: token,
      authTokenSecret: secret
  );
  await _auth.signInWithCredential(credential);
}