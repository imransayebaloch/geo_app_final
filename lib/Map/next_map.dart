import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapsDemo extends StatefulWidget {

  var latAndLong = new List();
  MapsDemo({Key key, this.latAndLong}) : super(key: key);

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  //var latnAdlong = new List();


  //
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(30.1909521, 66.9714362);            //85.521563, -122.677433
  final Set<Marker> _markers = {};                        // 30.1909521, 66.9714362
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(10.1909521, 6.9714362),
    tilt: 50.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

      // Widget button(Function function, IconData icon) {
      //
      //   return FloatingActionButton(
      //     heroTag: 'u',
      //   //  tooltip: 'map12',
      //     onPressed: function,
      //     materialTapTargetSize: MaterialTapTargetSize.padded,
      //     backgroundColor: Colors.blue,
      //     child: Icon(
      //       icon,
      //       size: 36.0,
      //     ),
      //   );
      // }
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target:  _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                    heroTag: 'a',
                      tooltip: 'setlite',
                    onPressed: (){
                      _onMapTypeButtonPressed();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: Icon(
                   // icon,
                      Icons.map,
                    size: 36.0,
                    ),
                    ),

                  //  button( _onMapTypeButtonPressed, Icons.map,),

                    SizedBox(
                      height: 16.0,
                    ),
                    FloatingActionButton(
                      heroTag: 'b',
                      tooltip: 'marker',
                      onPressed: (){
                        _onAddMarkerButtonPressed();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        // icon,
                        Icons.add_location,
                        size: 36.0,
                      ),
                    ),


                  //  button(_onAddMarkerButtonPressed, Icons.add_location),
                    SizedBox(
                      height: 16.0,
                    ),

                    FloatingActionButton(
                      heroTag: 'c',
                      tooltip: 'Position',
                      onPressed: (){
                        _goToPosition1();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        // icon,
                        Icons.location_searching,
                        size: 36.0,
                      ),
                    ),



                   // button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
          ],
        ),

      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
//if(listOfCoordinates!=null){}
      //listOfCoordinates.add(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

}