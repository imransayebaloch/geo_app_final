import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_app_final/server_response.dart';
import 'package:geolocator/geolocator.dart';
import 'dbmanager.dart';
import 'submit_coodinates.dart';
import 'main.dart';
import 'dart:async';
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
  final DbStudentManager dbmanager = new DbStudentManager();
  LatlngTarget target;

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
            height: 200,
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
                  if (_currentPosition != null)
                    for(int i = 0; i < listOfCoordinates.length; i++)
                      Center(
                        child: Text(("Position: ${i + 1} LAT: ${listOfCoordinates[i]
                            .latitude}, LNG: ${listOfCoordinates[i].longitude}"),style: TextStyle(fontSize: 14),
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

          Padding(
            padding: const EdgeInsets.only(top: 80,left: 40),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:
                  Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        child: Text('Revert'),
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown()));
                      //_getCurrentLocation();
                    },
                  ),
                ),
                ),
                Expanded( child:
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: FlatButton(
                    child: Text("Collect"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      setState(()=> itemcount++);
                      _getCurrentLocation();
                    //  _sendDataToserverScreen();
                    },
                  ),
                ),
                ),
              ],
            ),
          ),
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
//      if(listOfCoordinates[listOfCoordinates.length-1].latitude.toString()==position.latitude.toString()){
//      listOfCoordinates.add(position);
//      print("position here  $position");
//      Fluttertoast.showToast(
//          msg: "Cordinates of this point is already collected please move to next",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );}

      //print('hello $_currentPosition' + 'jjj');
    //  print('list print $listOfCoordinates');
      // var arr = new List();
      // for(int b=0; b<listOfCoordinates.length; b++) {
      //   // arr [b] = position;
      //   print("arry test)" + listOfCoordinates.);
      // }
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
