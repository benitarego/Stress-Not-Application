import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/Essentials/Loading.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool loading = false;

  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '4xHhtirZfM5ejlT5ecQKVGhgv',
      consumerSecret: 'iVkSlSYKQHCTYKls57cbKd9yPQJVup3f35LgMT8ZekTnAz5hlZ'
  );

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("My Profile", style: TextStyle(color: Colors.white),),
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
                          padding: EdgeInsets.only(top:10, left: 10, right: 10),
                          child: Container(
                            child: FutureBuilder(
                              future: FirebaseAuth.instance.currentUser(),
                              builder: (context, snapshot) {
                                FirebaseUser firebaseUser = snapshot.data;
                                return snapshot.hasData
                                    ? Column(
                                      children: <Widget>[
                                        Container(
                                          height: 260,
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
                                              SizedBox(height: 10),
                                              Text("@regobenita", style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Roboto'),),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('135', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
                                                        Text('tweets', style: TextStyle(color: Colors.white),),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('34', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
                                                        Text('followers', style: TextStyle(color: Colors.white),),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('49', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                          hoverColor: Color(0xffe4edff),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xff3ac758),
                                            radius: 10,
                                          ),
                                          title: Text('Positive tweets'),
                                          trailing: Text('57'),
                                          hoverColor: Color(0xffe4edff),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xff4782d6),
                                            radius: 10,
                                          ),
                                          title: Text('Neutral tweets'),
                                          trailing: Text('52'),
                                          hoverColor: Color(0xffe4edff),
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xfff75c40),
                                            radius: 10,
                                          ),
                                          title: Text('Negative tweets'),
                                          trailing: Text('16'),
                                          hoverColor: Color(0xffe4edff),
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
                                        Divider(thickness: 0.8,),
                                        SizedBox(height: 20),
                                        Text('Account Analysis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 20),
                                        SfRadialGauge(
                                            axes:<RadialAxis>[RadialAxis(
                                                startAngle: 180,
                                                endAngle: 0,
                                                minimum: 0,
                                                // maximum: 100,
                                                showLabels: false,
                                                // showAxisLine: false,
                                                axisLineStyle: AxisLineStyle(thickness: 0.5,
                                                  thicknessUnit: GaugeSizeUnit.factor,
                                                  gradient: const SweepGradient(
                                                      colors: <Color>[Color(0xffff4132), Color(0xffff8c00), Color(0xffffd600), Color(0xffc8dd15), Color(0xff69c43a)],
                                                      stops: <double>[0.2, 0.4, 0.6, 0.8, 1],

                                                  ),
                                                ),
                                                // ranges: <GaugeRange>[
                                                //   GaugeRange(
                                                //     startValue: 0,
                                                //     endValue: 33.33,
                                                //     color: Colors.green,
                                                //   ),
                                                //   GaugeRange(
                                                //     startValue: 33.33,
                                                //     endValue: 66.66,
                                                //     color: Colors.orange,
                                                //   ),
                                                //   GaugeRange(
                                                //     startValue: 66.66,
                                                //     endValue: 100,
                                                //     color: Colors.red,
                                                //   )
                                                // ],
                                                pointers: <GaugePointer>[
                                                  NeedlePointer(value: 57.2)
                                                ],
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                    widget: Container(
                                                      child: const Text('57.2',
                                                        style: TextStyle(
                                                          fontSize: 25, fontWeight: FontWeight.bold)
                                                        )
                                                    ),
                                                    angle: 90,
                                                    positionFactor: 0.5
                                                  )
                                                ]
                                            ),
                                            ]
                                        ),
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
