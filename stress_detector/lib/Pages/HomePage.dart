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
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

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

  _launchArticle1URL() async {
    const url = 'https://zenhabits.net/10-simple-ways-to-live-a-less-stressful-life/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchArticle2URL() async {
    const url = 'http://itsoktotalk.in/find-help/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTalktoExpert() async {
    const url = 'http://www.samaritansmumbai.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // _controller = VideoPlayerController.network(
    //     "https://github.com/benitarego/Mental-Health-Analysis/tree/master/stress_detector/videos/mental.mp4");
    _controller = VideoPlayerController.asset("videos/mental.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    // _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
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
                height: 195,
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
                      padding: EdgeInsets.only(left: 20, top: 20),
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
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: FlatButton.icon(
                              onPressed: () {
                                launch("tel:918422984528");
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
                              onPressed: () {
                                _launchTalktoExpert();
                              },
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
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text('Coping with Stress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),),
                        ),),
                        SizedBox(height: 20),
                        FadeAnimation(0.7, Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 210.0,
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
                        FadeAnimation(0.9, Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: GestureDetector(
                            onDoubleTap: _launchArticle1URL,
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
                                      ],
                                    )
                                  ],
                                )
                            ),
                          )
                        ),),
                        FadeAnimation(1.1, Padding(
                          padding: const EdgeInsets.only(left: 20, right:20, top: 10),
                          child: Container(
                            height: 310,
                            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                            decoration: BoxDecoration(
                              color: kThemeColor,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("What is Mental Health?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text("Get to know more about it in this video.", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 15),),
                                SizedBox(height: 10,),
                                FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return Center(
                                          child: _controller.value.initialized ? FittedBox(
                                            fit: BoxFit.cover,
                                            child: SizedBox(
                                              height: _controller.value.size?.height ?? 0,
                                              width: _controller.value.size?.width ?? 0,
                                              child: VideoPlayer(_controller),
                                            )
                                          ) : Text('No video to show', style: TextStyle(color: Colors.white),)
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                      } else {
                                        // If the video is paused, play it.
                                        _controller.play();
                                      }
                                    });
                                  },
                                  color: Colors.white,
                                  icon: Icon(
                                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.1, Padding(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                            child: GestureDetector(
                              onDoubleTap: _launchArticle2URL,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 160,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFA5BDE9)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset('assets/itsoktotalk.png', height: 150, width: 150),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 8),
                                          Text("It's OK to Talk!", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          SizedBox(height: 10),
                                         Text("'It's OK to Talk' is a safe\nspace to share your\nexperience with mental\nhealth, mental illness\nand well being.",
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 15
                                             ),),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                            )
                        ),),
                        SizedBox(height: 40,),
                        Text("Made with ❤️ from Stress Not! Team", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15),),
                        SizedBox(height: 20,),
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
