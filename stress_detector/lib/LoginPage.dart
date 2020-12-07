import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/DashboardPage.dart';
import 'package:stress_detector/FadeAnimation.dart';
import 'package:stress_detector/Loading.dart';
import 'package:stress_detector/ThemeColor.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final String uid;
  LoginScreen({Key key, this.uid}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  //Twitter sign in
  final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '1090237519634022403-2g8OdxA3VoKq5996Ysy6y3YMrfNTqz',
    consumerSecret: '3x1A2iLFCFOVf1n3dBv4CuspEB9DZ8MXirwk1U5nBy6x7'
  );

  String title = "";

  void login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String message;

    if (result.status == TwitterLoginStatus.loggedIn) {
      final AuthCredential credential = TwitterAuthProvider.getCredential(
          authToken: result.session.token, authTokenSecret: result.session.secret);
      await auth.signInWithCredential(credential);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => DashboardPage()
          )
      );
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      message = 'Login cancelled by user!';
    } else {
      message = result.errorMessage;
    }

    setState(() {
      title = message;
    });

    void _logout() async {
      await twitterLogin.logOut();
      await auth.signOut();
      setState(() {
        title = 'Logged out!';
      });
    }
  }
  String message;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
      ),
      body: Container(
          color: Colors.white70,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 80.0,),
                    FadeAnimation(0.2,
                      Image.asset('assets/applogo.png', width: 90.0, height: 90.0,),
                    ),
                    SizedBox(height: 20.0,),
                    FadeAnimation(0.4,
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
                    FadeAnimation(0.6,
                      Text('Login to your Twitter account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    GestureDetector(
                      onDoubleTap: login,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: FadeAnimation(0.8,
                            Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 60,),
                                  Image.asset('assets/twitter.png', width: 30.0, height: 30.0,),
                                  SizedBox(width: 20,),
                                  Text("Login with Twitter", style: TextStyle(color: Colors.white, fontSize: 20),)
                                ],
                              ),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeAnimation(1.0,
                        Text(
                          message == null ? "" : message,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15
                          ),
                        )
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

