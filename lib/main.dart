import 'dart:async';


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App',
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.red,
        
      ),
      backgroundColor: Colors.amber,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,color: Colors.red),
      )
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // late File img ;
  // final pikerperer = ImagePicker();
  











  var atut ;
  var longt ;
  late CameraPosition _kGooglePlex;


  bool status = false;
  Future GetGeologe() async {
    bool positi = await Geolocator.isLocationServiceEnabled();
    positi == false ? status = false : status = true;

    LocationPermission ispermit = await Geolocator.checkPermission();
    if (ispermit == LocationPermission.denied) {
      ispermit = await Geolocator.requestPermission();
      if (ispermit == LocationPermission.whileInUse) {
        getlongandatut();
        // print(ispermit);
      }
      else {
        print("none");
      }
    }
  }
  Future<void> getlongandatut() async {
    Position po = await Geolocator.getCurrentPosition().then((value) => value);
    atut = po.latitude;
    longt = po.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(atut, longt),
      zoom: 14.4746,
    );
    setState(() {
      
    });
  }


  @override
  void initState() {
    GetGeologe();
    getlongandatut();
    
    super.initState();
  }


   Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            
          children: [
            atut == null ? CircularProgressIndicator():
            Container(
              height: 700,
              color: Colors.grey,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
