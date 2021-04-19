import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/Essentials/Loading.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_detector/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool loading = false;

  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '9b8smdO0UloxZojzQ3Eh4zR7e',
      consumerSecret: 'MhmYPAiSSeoThxzvGtpSfwEQKuklKbDkQeen9q2Wrsb9bJjhJL'
  );

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("Profile", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: kThemeColor,
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
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: kThemeColor,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(30),
                            //     bottomRight: Radius.circular(30)
                            // )
                        ),
                      ),
                    ),
                    Positioned(
                      child: Padding(
                          padding: EdgeInsets.only(top:10, left: 20, right: 20),
                          child: Container(
                            child: FutureBuilder(
                              future: FirebaseAuth.instance.currentUser(),
                              builder: (context, snapshot) {
                                FirebaseUser firebaseUser = snapshot.data;
                                return snapshot.hasData
                                    ? Column(
                                      children: <Widget>[
                                        Container(
                                          height: 250,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20),
                                              firebaseUser.photoUrl == null
                                                  ? CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor: Colors.black
                                              ) : CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(firebaseUser.photoUrl),
                                              ),
                                              SizedBox(height: 15),
                                              Text("${firebaseUser.displayName}", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Roboto'),),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('129', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                                                        Text('tweets', style: TextStyle(color: Colors.white),),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('35', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                                                        Text('followers', style: TextStyle(color: Colors.white),),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('48', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                                                        Text('following', style: TextStyle(color: Colors.white),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text('Overall Analysis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 15),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: AssetImage('assets/twitterc.png'),
                                            backgroundColor: Colors.transparent,
                                            radius: 15,
                                          ),
                                          title: Text('Total tweets'),
                                          trailing: Text('135'),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xff3ac758),
                                            radius: 10,
                                          ),
                                          title: Text('Positive tweets'),
                                          trailing: Text('57'),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xff4782d6),
                                            radius: 10,
                                          ),
                                          title: Text('Neutral tweets'),
                                          trailing: Text('52'),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xfff75c40),
                                            radius: 10,
                                          ),
                                          title: Text('Negative tweets'),
                                          trailing: Text('16'),
                                        ),
                                        // Container(
                                        //   padding: EdgeInsets.all(20),
                                        //   height: 70,
                                        //   width: MediaQuery.of(context).size.width,
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.black,
                                        //       borderRadius: BorderRadius.circular(15)
                                        //   ),
                                        //   child: Row(
                                        //     children: <Widget>[
                                        //       Icon(Icons.ac_unit, color: Colors.white,),
                                        //       SizedBox(width: 5),
                                        //       Text("Total tweets", style: TextStyle(fontSize: 16, color: kThemeColor, fontFamily: 'Roboto'),),
                                        //       SizedBox(width: 5),
                                        //       Text(": 129", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto'),),
                                        //     ],
                                        //   ),
                                        // ),
                                        SizedBox(height: 10),
                                      ],
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(backgroundColor: kThemeColor,)
                                );
                              },
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ],
            )
        )
    );
  }
}
