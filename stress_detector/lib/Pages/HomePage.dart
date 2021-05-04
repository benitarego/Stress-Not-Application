import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_detector/Essentials/FadeAnimation.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:stress_detector/LoginPage.dart';
import 'package:stress_detector/Essentials/Loading.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '4xHhtirZfM5ejlT5ecQKVGhgv',
      consumerSecret: 'iVkSlSYKQHCTYKls57cbKd9yPQJVup3f35LgMT8ZekTnAz5hlZ'
  );

  // final String url = "https://health.gov/myhealthfinder/api/v3/topicsearch.json?TopicId=30560";
  // List articles;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   this.getJsonData();
  // }
  //
  // Future<String> getJsonData() async {
  //   var response = await http.get(
  //       Uri.encodeFull(url),
  //   );
  //
  //   print(response.body);
  //
  //   setState(() {
  //     var convertDataToJson = jsonDecode(response.body);
  //     articles = convertDataToJson['Result'];
  //   });
  //
  //   return "Success";
  // }


  _launchURL() async {
    const url = 'https://zenhabits.net/10-simple-ways-to-live-a-less-stressful-life/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("Dashboard", style: TextStyle(color: Colors.white),),
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kThemeColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Welcome!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Do you want to talk to someone?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text('If you feel any negative vibes within you, you can call our expert consultant for help and assistance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: FlatButton.icon(
                              onPressed: () {
                                launch("tel://9152987821");
                              },
                              icon: Icon(Icons.phone, color: Colors.white,),
                              label: Text('Call Now', style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.red,
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.messenger, color: Colors.white,),
                              label: Text('Chat with expert', style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.green,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(0.5, Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text('Coping with Stress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),),
                        ),),
                        SizedBox(height: 20),
                        FadeAnimation(0.7, Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 190.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/1.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Text('Talk with your family and friends', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/2.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Text('Relax with meditation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/3.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Text('Focus on positive activities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/4.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Text('Keep a healthy lifestyle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/5.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Text('Maintain a routine where possible', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 160,
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/6.jpg', height: 130, width: 130,),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text('Talk to a counsellor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),),
                        SizedBox(height: 20),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20),
                        //   height: 300.0,
                        //   child: ListView.builder(
                        //       itemCount: articles == null ? 0 : articles.length,
                        //       itemBuilder: (context, index) {
                        //         return Container(
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 color: Colors.white70
                        //             ),
                        //             child: Text(articles[index]['Title'], style: TextStyle(fontSize: 20, color: Colors.black),)
                        //         );
                        //       }
                        //   )
                        // )
                        FadeAnimation(0.9, Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: GestureDetector(
                            onDoubleTap: _launchURL,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                height: 155,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFA5BDE9)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset('assets/mental-health.jpg'),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 8),
                                        Text('Lead a stress free\nlifestyle!', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(height: 10),
                                        Text('Follow the instructions\nto follow the routine.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15
                                          ),),
                                        SizedBox(height: 10),
                                        // GestureDetector(
                                        //   onDoubleTap: () {},
                                        //   child: Container(
                                        //     width: 80,
                                        //     height: 25,
                                        //     padding: EdgeInsets.only(left: 7, right: 2),
                                        //     decoration: BoxDecoration(
                                        //         color: Color(0xFF3744ac),
                                        //         borderRadius: BorderRadius.circular(30)
                                        //     ),
                                        //     child: Row(
                                        //       mainAxisAlignment: MainAxisAlignment.center,
                                        //       children: <Widget>[
                                        //         Text('Click', style: TextStyle(color: Colors.white, fontSize: 14),),
                                        //         SizedBox(width: 3,),
                                        //         Icon(Icons.double_arrow, color: Colors.white,)
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )
                                  ],
                                )
                            ),
                          )
                        ),)
                      ],
                    ),
                  )
              ),
            ],
          )
        ),
    );
  }
}
