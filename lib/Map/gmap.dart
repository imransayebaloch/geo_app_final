import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geo_app_final/collect_lat_long.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GMap extends StatefulWidget {
 // var mapLatLong = new List();
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {


  MapType _currentMapType = MapType.normal;
  //Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon =
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');

    if (_showMapStyle) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78693, -122.41942));
    polygonLatLongs.add(LatLng(37.78923, -122.41542));
    polygonLatLongs.add(LatLng(37.78923, -122.42582));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

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

  // _onMapTypeButtonPressed(){
  //   setState(() {
  //
  //   });
  // }


  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  // static final CameraPosition _position1 = CameraPosition(
  //   bearing: 192.833,
  //   target: LatLng(45.531563, -122.677433),
  //   tilt: 59.440,
  //   zoom: 11.0,
  // );
  //
  // Future<void> _goToPosition1() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  // }


  Position _currentPosition;
  List<Position> listOfCoordinates = new List();
  int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: <Widget>[

          // Text('Volume : $_volume')
          // button(_onMapTypeButtonPressed, Icons.map),
          GoogleMap(

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
          Padding(
            padding: const EdgeInsets.only(left: 0 ,right: 270),
            child: Container(
            child:  Column(
              //  mainAxisAlignment: MainAxisAlignment.end)
              //mainAxisAlignment: MainAxisAlignment.start,

                children: [



                 //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                   FloatingActionButton(
                    tooltip: 'setlite',
                    child: Icon(Icons.map),
                    onPressed: () {

                      _onMapTypeButtonPressed();
                      print('map test prssed');
                      // setState(() {
                      //  // _getCurrentLocation();
                      //   //   _showMapStyle = !_showMapStyle;
                      // });

                      //_toggleMapStyle();
                    },
                  ),
                  SizedBox(height: 10,),

                  FloatingActionButton(
                    tooltip: 'collect',
                    child: Icon(Icons.add),
                    onPressed: () {

                      _sendDataToCollectSceen(context);
                    //  _onMapTypeButtonPressed();
                      print('map test prssed');
                    },
                  ),

                  SizedBox(height: 10,),

                  FloatingActionButton(
                    tooltip: 'map',
                    child: Icon(Icons.add_location),
                    onPressed: () {
                      _getCurrentLocation();
                      //  _onMapTypeButtonPressed();
                      //_goToPosition1();
                      _onMapTypeButtonPressed();

                      print('setlite test prssed');
                      setState(() {
                        //   _showMapStyle = !_showMapStyle;
                      });
                      //_toggleMapStyle();
                    },
                  ),



                  // IconButton(
                  //   icon: Icon(Icons.add_location, size: 70, color: Colors.blueAccent,),
                  //   tooltip: 'camera ',
                  //   onPressed: () {
                  //   //  _showChoiceDialog(context);
                  //     print('Volume button clicked');
                  //   },
                  // ),
                //  _DecideImageView(),
                ],
              ),

            // child:  Padding(
            //     padding: const EdgeInsets.only(right: 40.0),
            //     child: FlatButton(
            //       child: Text("Test GPS"),
            //       color: Colors.blueAccent,
            //       onPressed: () {
            //         setState(()=> itemcount++);
            //         _getCurrentLocation();
            //         //  _sendDataToserverScreen();
            //       },
            //     ),
            //   ),

              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
            //  child: Text("Coding with Imran Syed"),
            ),
          )
        ],
      ),


       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: Icon(Icons.map),
      //   onPressed: () {
      //   //  _onMapTypeButtonPressed();
      //     //_goToPosition1();
      //     _onMapTypeButtonPressed();
      //     print('map test prssed');
      //     setState(() {
      //    //   _showMapStyle = !_showMapStyle;
      //     });
      //     //_toggleMapStyle();
      //   },
      // ),

    );
  }

  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      listOfCoordinates.add(position);

      setState(() {
        _currentPosition = position;
        print('my gps now$position');
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _sendDataToCollectSceen (BuildContext context) {
//    print();?
    Navigator.push(
        context,
        MaterialPageRoute(
         // builder: (context) => HomePage(MapLatLong: listOfCoordinates),  // collectedList: listOfCoordinates
        ));
  }

}