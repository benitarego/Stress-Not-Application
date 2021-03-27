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
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, snapshot) {
              FirebaseUser firebaseUser = snapshot.data;
              return snapshot.hasData
                  ? Container(
                    height: 320,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        firebaseUser.photoUrl == null
                            ? CircleAvatar(
                            minRadius: 50,
                            maxRadius: 50,
                            backgroundColor: Colors.black
                        ) : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(firebaseUser.photoUrl),
                        ),
                        SizedBox(height: 15),
                        Text("${firebaseUser.displayName}", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Roboto'),),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Total tweets", style: TextStyle(fontSize: 16, color: kThemeColor, fontFamily: 'Roboto'),),
                            SizedBox(width: 5),
                            Text(": 129", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                          ],
                        ),
                        // SizedBox(height: 10,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Text("Total retweets", style: TextStyle(fontSize: 16, color: kThemeColor, fontFamily: 'Roboto'),),
                        //     SizedBox(width: 5),
                        //     Text(": 76", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                        //   ],
                        // ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey, thickness: 0.5,),
                        SizedBox(height: 10,),
                        Text('Overall Analysis', style: TextStyle(color: Colors.grey, fontSize: 18),),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.green,
                                ),
                                SizedBox(width: 5),
                                Text(": 57", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(width: 5),
                                Text(": 52", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(width: 5),
                                Text(": 20", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(backgroundColor: kThemeColor,)
              );
            },
          ),
        ),
      )
    );
  }
}
