import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:collection';

class MapsDemo extends StatefulWidget {
 // List<LatLng> latAndLong = new List();
  List<Position> latAndLong = new List();
  MapsDemo({Key key, this.latAndLong}) : super(key: key);
//  LatLng imran = latAndLong;
  final String title = "Location ";



  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center =
      const LatLng(30.1909521, 66.9714362); //85.521563, -122.677433

  LatLng _lastMapPosition = _center;
 // MapType _currentMapType = MapType.normal;

  // Set<Polyline> _polylines = HashSet<Polyline>();

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(37.78493, -122.42932),
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

  MapType _currentMapType = MapType.normal;
  //Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = true;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
   // getPoints();
    getPoint1();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    if (_showMapStyle) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

 void  _setPolygons() {

   List<LatLng> polygonLatLongs = List<LatLng>();
// if(polygonLatLongs.isEmpty){
//   polygonLatLongs.add(LatLng(36.78493, -128.42932));
//   polygonLatLongs.add(LatLng(39.88257, -128.42582));
//    polygonLatLongs.add(LatLng(39.78693, -122.41942));
//    polygonLatLongs.add(LatLng(36.78923, -122.66985));
// }else{
//   for(int i = 0; i < widget.latAndLong.length; i++){
//     polygonLatLongs.add(LatLng(widget.latAndLong[i].latitude, widget.latAndLong[i].longitude));
//   }
// }

   //  polygonLatLongs.add(LatLng(36.78493, -128.42932));
   //  polygonLatLongs.add(LatLng(39.88257, -128.42582));
   //  polygonLatLongs.add(LatLng(39.78693, -122.41942));
   //  polygonLatLongs.add(LatLng(36.78923, -122.66985));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points:  polygonLatLongs, //polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    // widget.latAndLong;
   //  List<LatLng> polylineLatLongs = [
    //   latAndLong
    // ]; //= List<LatLng>();
        List<LatLng> polylineLatLongs = List<LatLng>();
    // List polylineLatLongs;
    // polylineLatLongs.add({widget.latAndLong});

    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        //   points: widget.latAndLong,
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

  // void _onMapCreated(GoogleMapController controller) {
  //   _mapController = controller;
  //
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //           markerId: MarkerId("0"),
  //           position: LatLng(37.77483, -122.41942),
  //           infoWindow: InfoWindow(
  //             title: "San Francsico",
  //             snippet: "An Interesting city",
  //           ),
  //           icon: _markerIcon),
  //     );
  //   });
  // }

  // _onMapTypeButtonPressed(){
  //   setState(() {
  //
  //   });
  // }

  /* _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }*/

  // void _setPolylines() {
  //   List<LatLng> polylineLatLongs = List<LatLng>();
  //   polylineLatLongs.add(LatLng(10.1909521, 6.9714362));
  //   polylineLatLongs.add(LatLng(10.74693, 7.41942));
  //   polylineLatLongs.add(LatLng(12.74923, 8.41542));
  //   polylineLatLongs.add(LatLng(10.74923, 10.42582));
  //
  //   _polylines.add(
  //     Polyline(
  //       polylineId: PolylineId("0"),
  //       points: polylineLatLongs,
  //       color: Colors.purple,
  //       width: 1,
  //     ),
  //   );
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _setPolylines();
  // }

  // _setPolylines2() {
  //   Set<Polygon>.of(<Polygon>[
  //     Polygon(
  //         polygonId: PolygonId('area'),
  //         points: getPoints(),
  //         geodesic: true,
  //         strokeColor: Colors.red.withOpacity(0.6),
  //         strokeWidth: 5,
  //         fillColor: Colors.redAccent.withOpacity(0.1),
  //         visible: true),
  //   ]);
  // }
   getPoint1(){
     List<LatLng> polygonLatLongs = List<LatLng>();
   if(widget.latAndLong.isEmpty){
    polygonLatLongs.add(LatLng( 36.78493, -128.42932));
   }else{
    // List<LatLng> polygonLatLongs = List<LatLng>();
   for(int i = 0; i < widget.latAndLong.length; i++){
     polygonLatLongs.add(LatLng(widget.latAndLong[i].latitude, widget.latAndLong[i].longitude));
      }
   }
   return polygonLatLongs;
  }

/*  getPoints() {
    return [
    for(int i = 0; i < widget.latAndLong.length; i++){
        LatLng(widget.latAndLong[i].latitude , widget.latAndLong[i].longitude ),
      }

       LatLng(36.78493, -128.42932),
       LatLng(39.88257, -128.42582),
      LatLng(39.78693, -122.41942),
      LatLng(36.78923, -122.66985),
    ];
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[
            // GoogleMap(
            //   onMapCreated: _onMapCreated,
            //   initialCameraPosition: CameraPosition(
            //     target: _center,
            //     zoom: 11.0,
            //   ),
            //   polygons: _polygons,
            //   polylines: _polylines,
            //   circles: _circles,
            //   mapType: _currentMapType,
            //   markers: _markers,
            //   onCameraMove: _onCameraMove,
            //   myLocationEnabled: true,
            // ),

            GoogleMap(
              // onLongPress: _getCurrentLocation,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center, // LatLng( 37.77483 , -122.41942),
                zoom: 12,
              ),
             // gestureRecognizers: _onAddMarkerButtonPressed(),
             // onLongPress: ,
              markers: _markers,
              polylines: _polylines,
              circles: _circles,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapType: _currentMapType,
              polygons: Set<Polygon>.of(<Polygon>[
                Polygon(
                    polygonId: PolygonId('area'),
                    points:   getPoint1(),
                    geodesic: true,
                    strokeColor: Colors.red.withOpacity(0.6),
                    strokeWidth: 5,
                    fillColor: Colors.redAccent.withOpacity(0.1),
                    visible: true),
              ]),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'a',
                      tooltip: 'setlite',
                      onPressed: () {
                        //  _setPolylines();
                        _onMapTypeButtonPressed();
                        print('my lat long ${widget.latAndLong}');
                        // for (int i = 0; i < widget.latAndLong.length; i++) {
                        //   print(widget.latAndLong[]);
                        //   List<LatLng> Locationlatlong = new List();
                        //   Locationlatlong.add(widget.latAndLong[i]);
                        // }
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
                      onPressed: () {
                        //   print('my list ${widget.latAndLong}');
                         _onAddMarkerButtonPressed();
                        print('latiiii ${widget.latAndLong}');
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
                      onPressed: () {
                        _goToPosition1();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        // icon,
                        Icons.location_searching,
                        size: 36.0,
                      ),
                    ), // button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
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

  // void _getUserLocation2() async {
  //   var position = await   Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);     //GeolocatorPlatform.instance
  //
  //   setState(() {
  //     currentPostion = LatLng(position.latitude, position.longitude);
  //   });
  // }

  // void _getUserLocation() async {
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
  //   setState(() {
  //     _initialPosition = LatLng(position.latitude, position.longitude);
  //     print('${placemark[0].name}');
  //   });
  // }

}
