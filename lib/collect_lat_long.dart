import 'dart:collection';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_app_final/Map/gmap.dart';
import 'package:geo_app_final/server_response.dart';
import 'package:geolocator/geolocator.dart';
import 'DBmanager/dbmanager.dart';
import 'submit_coodinates.dart';
import 'Main/main.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


//import 'main3.dart';
/* class MyApp extends StatelessWidget {
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
} */

class HomePage extends StatefulWidget {
  String department= "";
  int id;

  String  secondname = "";
  int secondid;
  HomePage({Key key ,this.id ,this.department, this.secondid,this.secondname}): super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MapType _currentMapType = MapType.normal;
  //Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;


  final DbStudentManager dbmanager = new DbStudentManager();
  LatlngTarget target;


  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(37.77483, -122.41942),
            infoWindow: InfoWindow(
              title: "San Francsico",
              snippet: "An Interesting city",
            ),
            icon: _markerIcon),
      );
    });
  }


  Widget potrate(){
    return  Container(
      child:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(str),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Coardinator Collection'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110,),
                  child: FlatButton(
                    color: Colors.grey,
                    child: Text('Done'),
                    onPressed: (){
                    //  print("")
                      _submitTarget(context);
                      _sendDataToSubmitCoordinate(context);

                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCoordinat() ) );//str: "hello"
                    },
                  ),
                ),
              ],
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text('PROJECt: ' +  widget.department ,
                  style: TextStyle(fontWeight: FontWeight.bold) ),

              Text('TARGET  : '+ widget.secondname,
                  style: TextStyle(fontWeight: FontWeight.bold) ),
            ],
          ),


          // Column(
          //   children: [
          Container(
            //  color: Colors.amber[600],
            height: 80,
            width: 320,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            //  color: Colors.yellow,
            child:
            Expanded(
              child:
              ListView(
                children: <Widget>[


                  if (_currentPosition != null  )
                    for(int i = 0; i < listOfCoordinates.length; i++)
                      GestureDetector(
                        onHorizontalDragEnd: (endxy){
                          listOfCoordinates.removeAt(i);
                          itemcount --;
                          setState(() {
                          });
                        },


                        child: Center(


                          child: Text(("Position: ${i + 1} LAT: ${listOfCoordinates[i]
                              .latitude}, LNG: ${listOfCoordinates[i].longitude}"),style: TextStyle(fontSize: 14),
                           ),
                        ),
                      ),
                ],
              ),
            ),
          ),
          //   SizedBox.fromSize()
          Padding(
            padding: const EdgeInsets.only(right: 150, top:10),
            child: Text(
              ' $itemcount Coordinates Collected ' ,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Divider(
              color: Colors.black
          ),

          Padding(
            padding: const EdgeInsets.only(right: 0, top:10,bottom: 10),
            child: Text(
              'Tap on collect to record current coardinate or\n                   revert to go one step back',
              style: TextStyle(fontWeight: FontWeight.bold),

            ),
          ),
          Divider(
              color: Colors.black
          ),

          Container(
            height: 220,
            width: 320,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),

          child:  GoogleMap(

              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.77483, -122.41942),
                zoom: 12,
              ),
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              circles: _circles,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                heroTag: "imran",
                tooltip: 'setlite',
                child: Icon(Icons.map),
                onPressed: () {
                  // _onMapTypeButtonPressed();
                  print('map test prssed');
                  // setState(() {
                  //  _getCurrentLocation();
                  //     _showMapStyle = !_showMapStyle;
                  // });

                 // _toggleMapStyle();
                },
              ),
              SizedBox(height: 10,),

              FloatingActionButton(
                heroTag: "syed",
                tooltip: 'map',
                child: Icon(Icons.add_location),
                onPressed: () {
                  _getCurrentLocation();
                  itemcount ++;
                  //  _onMapTypeButtonPressed();
                  //_goToPosition1();
                 // _onMapTypeButtonPressed();

                  print('setlite test prssed');
                  setState(() {
                    //   _showMapStyle = !_showMapStyle;
                  });
                  //_toggleMapStyle();
                },
              ),
            ],
          )

          //expended end here
        ],
      ),
    );
  }

 /* Widget landscape(){

  } */

  Position _currentPosition;
  List<Position> listOfCoordinates = new List();
  int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Collection'),

      ),
      body: OrientationBuilder(
        builder: (context, orientation ){
          if(orientation == Orientation.portrait){
            return potrate();

          }else {
            return null;
          }
        },
      )

    );

  }


  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
//if(listOfCoordinates!=null){}
      listOfCoordinates.add(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _sendDataToSubmitCoordinate (BuildContext context) {
//    print();?
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmitCoordinat(selectedCoordinat:  '$itemcount' , id: widget.id , department: widget.department, secondid: widget.secondid, secondname:widget.secondname,collectcor: listOfCoordinates),  // collectedList: listOfCoordinates
        ));
  }

  void _submitTarget(BuildContext context) {
    //if(_formKey.currentState.validate()){
    if (target == null) {
      for (int i = 0; i < listOfCoordinates.length; i++) {
        LatlngTarget tv = new   LatlngTarget (
            assetid: widget.id, lat: listOfCoordinates[i].latitude,lng:listOfCoordinates[i].longitude );//

        dbmanager.insertlocation(tv).then((id) =>

        //.clear(),
        // _courseController.clear(),

        //  print('Student Added to Db ${id} ${st.course}')
        print('test cordinate table ${tv.assetid} ')
          // }
        );
      }}
//    } else {
////      for (int i = 0; i < listOfUsers.length; i++) {
//      target.id = _currentUser.id;
//      target.name = _currentUser.name;
////      }
//      dbmanager.updateStudent(target).then((id) =>
//      {
//        setState(() {
////      for (int i = 0; i < listOfUsers.length; i++) {
//          studlist[updateIndex].id = _currentUser.id;
//          studlist[updateIndex].name = _currentUser.name;
////      }
//        }),
//        // _nameController.clear(),
//        // _courseController.clear(),
//        target = null
//      });
//    }
  }


  // void _sendDataToserverScreen (BuildContext context ) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ServerResponse( collectcor: listOfCoordinates),  // collectedList: listOfCoordinates
  //       ));
  // }

}
