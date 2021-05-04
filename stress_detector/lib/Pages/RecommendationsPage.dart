import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:stress_detector/LoginPage.dart';

class PlacesSearchMapSample extends StatefulWidget {
  @override
  State<PlacesSearchMapSample> createState() {
    return _PlacesSearchMapSample();
  }
}

class _PlacesSearchMapSample extends State<PlacesSearchMapSample> {

  static const String _API_KEY = 'AIzaSyAIFCtkfQICnpKwRiHWbryLqQ-Sb2RVOIA';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '4xHhtirZfM5ejlT5ecQKVGhgv',
      consumerSecret: 'iVkSlSYKQHCTYKls57cbKd9yPQJVup3f35LgMT8ZekTnAz5hlZ'
  );

  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Consultations", style: TextStyle(color: Colors.white),),
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
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out,color: kThemeColor, size: 40),
          onPressed: () {
            zoomVal--;
            _minus( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in,color: kThemeColor, size: 40,),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(19.081822, 72.851561), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(19.081822, 72.851561), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMPZnBuaULhDRG08-GBqGZTnkkJ510tcqn2RgAr=w408-h306-k-no",
                  19.080622447835268, 72.84220135423166,"R K Hospital"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPlSd5diiq9FgWfCLr9Kra-xymgI5oQDIqB3zLe=w408-h544-k-no",
                  19.07741985809697, 72.85817353888743,"Niron Hospital"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipNUBOlD-QPn2ZDin5lZNkbqvGMXWpUnvzUZo-ZO=w425-h240-k-no",
                  19.08089202913187, 72.85463538320347,"Aseem Hospital"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipP1_8aNIgxho7uwsbmFdzCIi7Hk2OEzwev2QVpd=w426-h240-k-no",
                  19.078968673512403, 72.84505134689485,"V N Desai Hospital"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMIoEVQtkDFnCJfjMZ7uLVRl0go-03rXnwdLI9-=w408-h725-k-no",
                  19.073194657932994, 72.84455627555363,"Sanjeevani Hospital"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipNDQhhtmbiXM31U1wHBYE7W9X9zBqEXb89-RmK0=w408-h306-k-no",
                  19.079106758007857, 72.86631646342134,"Sahyog Wellcare Hospital"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String hospName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer1(hospName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String hospName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(hospName,
                style: TextStyle(
                    color: kThemeColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(1046)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Indian \u00B7 \u0024\u0024 \u00B7 1.9 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Closed \u00B7 Opens 9:00 Mon",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(19.081822, 72.851561), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          vnMarker,sahyogMarker,rkMarker,nironMarker,aseemMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker rkMarker = Marker(
  markerId: MarkerId('rk'),
  position: LatLng(19.0803, 72.8422),
  infoWindow: InfoWindow(title: 'R K Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker nironMarker = Marker(
  markerId: MarkerId('niron'),
  position: LatLng(19.0772, 72.8582),
  infoWindow: InfoWindow(title: 'Niron Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker aseemMarker = Marker(
  markerId: MarkerId('aseem'),
  position: LatLng(19.08089202913187, 72.85463538320347),
  infoWindow: InfoWindow(title: 'Aseem Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//hosp Marker

Marker vnMarker = Marker(
  markerId: MarkerId('vn'),
  position: LatLng(19.078968673512403, 72.84505134689485),
  infoWindow: InfoWindow(title: 'V N Desai Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker sahyogMarker = Marker(
  markerId: MarkerId('sahyog'),
  position: LatLng(19.079106758007857, 72.86631646342134),
  infoWindow: InfoWindow(title: 'Sahyog Wellcare Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);