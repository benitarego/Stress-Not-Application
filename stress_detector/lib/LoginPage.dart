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
                    // GestureDetector(
                    //   onDoubleTap: login,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 30, right: 30),
                    //     child: FadeAnimation(0.8,
                    //         Container(
                    //           width: 100,
                    //           height: 60,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(50),
                    //               color: Colors.black
                    //           ),
                    //           child: Row(
                    //             children: <Widget>[
                    //               SizedBox(width: 60,),
                    //               Image.asset('assets/twitter.png', width: 30.0, height: 30.0,),
                    //               SizedBox(width: 20,),
                    //               Text("Login with Twitter", style: TextStyle(color: Colors.white, fontSize: 20),)
                    //             ],
                    //           ),
                    //         ),
                    //     ),
                    //   ),
                    // ),
                    FadeAnimation(0.8, InkWell(
                      onTap: () {
                        login();
                      },
                      borderRadius: BorderRadius.circular(30),
                      splashColor: kThemeColor,
                      child: Container(
                        height: 50,
                        width: 300,
                        child: Center(
                          child: Text(
                            'Sign In with Twitter',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.black,
                                width: 3
                            )
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
      Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => DashboardPage()
              )
          );
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      newMessage = 'Login cancelled by user!';
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
    consumerKey: 'IXo5uEathVAM3NIQcsYTioDTY',
    consumerSecret: 'rSfXe1a3Qk1V9B3DSrbcVJZrH402FLWvjsbiFQ9BvJ0MxWMJV6'
);

void _signInWithTwitter(String token, String secret) async {
  final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: token,
      authTokenSecret: secret
  );
  await _auth.signInWithCredential(credential);
}

_logout() async {
  await twitterLogin.logOut();
  await _auth.signOut();
}

// class LogOut extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//       ),
//       body: FutureBuilder(
//         future: FirebaseAuth.instance.currentUser(),
//         builder: (context, snapshot) {
//           FirebaseUser firebaseUser = snapshot.data;
//           return snapshot.hasData
//               ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "SignIn Success",
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text("UserId: ${firebaseUser.uid}"),
//                     SizedBox(height: 20),
//                     firebaseUser.photoUrl == null
//                         ? SizedBox(height: 0)
//                         : Image.network(firebaseUser.photoUrl, height: 100),
//                     Text("Your name: ${firebaseUser.displayName}"),
//                     Text("Your email: ${firebaseUser.email}"),
//                     SizedBox(height: 20,),
//                     RaisedButton(
//                       onPressed: () {
//                         _logout();
//                       },
//                       child: Text(
//                         "Logout",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       color: Colors.blue,
//                     )
//                   ],
//                 ),
//           )
//               : CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }