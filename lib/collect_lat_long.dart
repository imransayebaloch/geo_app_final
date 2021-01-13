import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'DBmanager/dbmanager.dart';
import 'questions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Map/map.dart';
import 'package:hexcolor/hexcolor.dart';


class HomePage extends StatefulWidget {
  static  const  String id2 = "coordinate_screen";
  String department = "";
  int id;
  String secondname = "";
  int secondid;
  HomePage({Key key, this.id, this.department, this.secondid, this.secondname})
      : super(key: key);
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

  LatLng _center;

  LatlngTarget target;

  Position currentLocation;

  Position _currentPosition;
  List<Position> listOfCoordinates =  new List();
 // List<LatLng> listOfCoordinates1 = new List();

  int itemcount = 0;
 // List<List<int>> result = coordinates.map( (data) => [ data.latitude , data.longitude ] ) ;
  @override
  void initState() {
    print('the value ${LocationAccuracy.values} ');
    // TODO: implement initState
   // for(int i=0 ;i<listOfCoordinates.length;i++){
      // listOfCoordinates1[i]= listOfCoordinates[i].latitude , listOfCoordinates[i].longitude as LatLng;
    //listOfCoordinates as LatLng;
 //   }
    super.initState();
   // getlatlong();
  }
List<LatLng> mylatLong = [
  LatLng(36.78493, -128.42932),
    LatLng(39.88257, -128.42582),
    LatLng(39.78693, -122.41942),
    LatLng(36.78923, -122.66985),
];

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

  Widget potrate() {
    return Container(
      // decoration: new BoxDecoration(
      //  color: HexColor('#E0E0E0'),),
      // Colors(int.parse('0X1231321')),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(str),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),

              child: Padding(
                padding: const EdgeInsets.only(right: 130),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
               //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                          'PROJECT  :   ${widget.department}                \nTARGET    :   ${widget.secondname}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Text(
                    //       'TARGET   :        ${widget.secondname}    ',
                    //       style: TextStyle(fontWeight: FontWeight.bold)),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),

         // Column(
           // children: [


          Container(
            // decoration: new BoxDecoration(
            //   color: HexColor('#E0E0E0'),),
            // Colors(int.parse('0X1231321')),
            //  color: Colors.amber[600],
            height: 300,
            width: 345,
           // alignment: ,
            //fcolor: Colors.red,
            decoration: BoxDecoration(
              color: HexColor('#E0E0E0'),
              //  color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),
            //  color: Colors.yellow,

            child: Expanded(
                child: Scrollbar(
                  child: ListView(
                    // child: Column(
                    children: <Widget>[
                      // _locationCheking(),
                      if (_currentPosition != null)
                        for (int i = 0; i < listOfCoordinates.length; i++)
                        //   if(listOfCoordinates[0].latitude == listOfCoordinates[0+1].longitude)

                        // if(listOfCoordinates[i].latitude == listOfCoordinates[i + 1].longitude)
                        //   Center(child: Text(' wow imran its true')),
                        // Fluttertoast.showToast(
                        // msg: 'Select both dropdown',
                        // toastLength: Toast.LENGTH_SHORT,
                        // gravity: ToastGravity.BOTTOM,
                        // // timeInSecForIos: 1,
                        // backgroundColor: Colors.blueGrey,
                        // textColor: Colors.white
                        // );
                        //   else
                        //_sendDataToSecondScreen(context);
                        // ,

                        // GestureDetector(
                        //   onHorizontalDragEnd: (endxy){
                        //     listOfCoordinates.removeAt(i);
                        //     itemcount --;
                        //     setState(() {
                        //     });

                          Center(
                            child: Text(
                              ("$i Lat: ${listOfCoordinates[i].latitude} , Lon:  ${listOfCoordinates[i].longitude}"), //${i + 1} LAT:
                              style: TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ),
                      //   ),
                    ],
                  ),
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ' $itemcount Coordinates Collected ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  size: 40,
                  color: Colors.red,
                ),
                tooltip: 'delete ',
                onPressed: () {
                  listOfCoordinates.removeLast();

                  itemcount--;
                  setState(() {});
                  //my code
                },
              ),
            ],
          ),

          Divider(color: Colors.black),

          Padding(
            padding: const EdgeInsets.only(right: 0, top: 10, bottom: 10),
            child: Text(
              'Tap on collect to record current coordinate or\n        Delete Icon to delete last coordinate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.black),

          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox.fromSize(
                  size: Size(56, 56), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.yellow, // splash color
                        onTap: () {
                         // getlatlong();
                          _sendToMap(context);
                         // print('the value ${LocationAccuracy.values} ');
                          //  getUserLocation();
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              color: Colors.white,
                            ), // icon
                            Text(
                              "Map",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 225),
                child: SizedBox.fromSize(
                  size: Size(56, 56), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.yellow,
                        // splash color
                        onTap: () {
                          _getCurrentLocation();
                          itemcount++;
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add_location,
                              color: Colors.white,
                            ),
                            // icon
                            Text(
                              "Get point",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Point'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _submitTarget(context);
                _sendDataToSubmitCoordinate(context);
                // sharedPreferences.clear();
                // sharedPreferences.commit();
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => LoginPage()),
                //     (Route<dynamic> route) => false);
              },
              child: Text("Done", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return potrate();
            } else {
              return null;
            }
          },
        ));
  }

  _getCurrentLocation() {
    
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
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


  void _sendDataToSubmitCoordinate(BuildContext context) {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmitCoordinat(
              selectedCoordinat: '$itemcount',
              id: widget.id,
              department: widget.department,
              secondid: widget.secondid,
              secondname: widget.secondname,
              collectcor: mylatLong), // collectedList: listOfCoordinates
        ));
  }

  void _submitTarget(BuildContext context) {
    //if(_formKey.currentState.validate()){
    if (target == null) {
      for (int i = 0; i < listOfCoordinates.length; i++) {
        LatlngTarget tv = new LatlngTarget(
            assetid: widget.id,
            lat: listOfCoordinates[i].latitude,
            lng: listOfCoordinates[i].longitude); //

        dbmanager.insertlocation(tv).then((id) =>

                //.clear(),
                // _courseController.clear(),

                //  print('Student Added to Db ${id} ${st.course}')
                print('test cordinate table ${tv.assetid} ')
            // }
            );
      }
    }
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

  void _sendToMap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Geo_map(
              latAndLong:
                  listOfCoordinates) // collectedList: listOfCoordinates
        ));
  }
  // void _sendDataToserverScreen (BuildContext context ) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ServerResponse( collectcor: listOfCoordinates),  // collectedList: listOfCoordinates
  //       ));
  // }

  void getCurrentPosition() async {
    Position currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
  }
}
