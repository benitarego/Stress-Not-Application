import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:stress_detector/LoginPage.dart';

class Onboarding extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
        PageViewModel(
          image: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 130),
            child: Image.asset('assets/socialmedia.png'),
          ),
          title: 'Social Media Content Analysis',
          body: 'Analyze your tweets, posts, retweets and likes'
        ),
        PageViewModel(
            image: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 130),
              child: Image.asset('assets/detect.png'),
            ),
            title: 'Detect Early Negativity',
            body: 'Alerting when the negative contents are beyond the level'
        ),
        PageViewModel(
            image: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 130),
              child: Image.asset('assets/doctor.jpg',),
            ),
            title: 'Consultation Recommendation',
            body: 'Consult a medical assistant at your own choice and will'
        ),
    ];
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(),
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          onSkip: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()
                )
            );
          },
          skip: const Text('Skip', style: TextStyle(color: kThemeColor),),
          next: const Icon(Icons.arrow_forward, color: kThemeColor,),
          done: Text('Done', style: TextStyle(color: kThemeColor)),
          onDone: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()
                )
            );
          },
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: kThemeColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
