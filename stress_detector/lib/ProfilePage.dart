import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:stress_detector/ThemeColor.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          RaisedButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
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
            child: Text(
              "Logout",
              style: TextStyle(color: kThemeColor),
            ),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, snapshot) {
            FirebaseUser firebaseUser = snapshot.data;
            return snapshot.hasData
                ? Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        firebaseUser.photoUrl == null
                            ? SizedBox(height: 0)
                            : CircleAvatar(
                          minRadius: 70,
                          maxRadius: 70,
                          backgroundImage: NetworkImage(firebaseUser.photoUrl),
                        ),
                        SizedBox(height: 20),
                        Text("${firebaseUser.displayName}", style: TextStyle(fontSize: 20, color: Colors.black),),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                : Center(
                child: CircularProgressIndicator(backgroundColor: kThemeColor,)
            );
          },
        ),
      ),
    );
  }
}
