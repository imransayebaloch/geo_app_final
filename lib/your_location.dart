/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
//import 'home_page.dart';

class MyApp1 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

//HomePage({})

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  Position _currentPosition;
  List<Position> listOfCoordinates = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Container (
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("drop down"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),

            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyApp()),
                    // );
                  //  print(_selectedCompany.name);
                   // Navigator.push(context, MaterialPageRoute(builder: (_)=> select.MyApp()));
                  },
                  child: Text(
                    "Continue",
                  )

              ),
            )

          ],
        ),
      ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      listOfCoordinates.add(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
} */




