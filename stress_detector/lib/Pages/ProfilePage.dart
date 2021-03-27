import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '9b8smdO0UloxZojzQ3Eh4zR7e',
      consumerSecret: 'MhmYPAiSSeoThxzvGtpSfwEQKuklKbDkQeen9q2Wrsb9bJjhJL'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 25,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              twitterLogin.logOut().then((res) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }).catchError((e) {
                print(e);
              });
              FirebaseAuth.instance.signOut();
              print('Signed Out');
            },
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
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        firebaseUser.photoUrl == null
                            ? CircleAvatar(
                            minRadius: 70,
                            maxRadius: 70,
                            backgroundColor: Colors.black
                            ) : CircleAvatar(
                          minRadius: 70,
                          maxRadius: 70,
                          backgroundImage: NetworkImage(firebaseUser.photoUrl),
                        ),
                        SizedBox(height: 20),
                        Text("${firebaseUser.displayName}", style: TextStyle(fontSize: 20, color: Colors.black),),
                        SizedBox(height: 20),
                        Text("${firebaseUser.email}", style: TextStyle(fontSize: 20, color: Colors.black),),
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