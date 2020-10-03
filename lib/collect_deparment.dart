import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'submit_coodinates.dart';
import 'main.dart';
import 'dart:async';





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
  HomePage({Key key ,this.id ,this.department}):super(key: key);
 // HomePage([this.id]),
    //  String str="" ;
    // HomePage({ Key key,this.str }):super(key: key );
   // HomePage({ Key key,this.str }):super(key: key );
   //HomePage({ Key key,  this.str }):super(key: key );

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

            // String  text;
            // _HomePageState({ Key key,this.str }):super(key: key );

  Position _currentPosition;
  List<Position> listOfCoordinates = new List();
  int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Collection'),

      ),
      body: Container(
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
                                _sendDataToSubmitCoordinate(context);

                              //  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCoordinat() ) );//str: "hello"

                              },
                            ),
                          ),
                        ],
                      ),
                    ),


                    Column(
                   children: [


                       Padding(
                         padding: const EdgeInsets.only(right: 160,left: 10),
                         child: Text('PROJECt: ' +  widget.department ,
                             style: TextStyle(fontWeight: FontWeight.bold) ),
                       ),



                     Padding(
                       padding: const EdgeInsets.only(right: 160 ,left: 10),
                       // child: Text('TARGET  : '+ widget.department,
                       //     style: TextStyle(fontWeight: FontWeight.bold) ),
                     ),
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



                  //   ],
                  // ),

                 //   ),
                 // ),






                    Padding(
                      padding: const EdgeInsets.only(top: 80,left: 40),

                      child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: FlatButton(
                        color: Colors.blueAccent,

                 child: Text('Revert'),
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.of(context).pop();
                       //  Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown(),));
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
                           print('hello test');
                           print(widget.id);
                           print(widget.department);
                           _getCurrentLocation();
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

    ),
    );

  }


  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      listOfCoordinates.add(position);
      print("position $position");
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _sendDataToSubmitCoordinate (BuildContext context) {
    // String textToSend = textFieldController.text;
    // String textToSend = imran;
    Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => HomePage(text: textToSend,),
          builder: (context) => SubmitCoordinat(selectedCoordinat:  '$itemcount' , id: widget.id , department: widget.department),
        ));
  }

 /* void _sendDataTosubmit(BuildContext context) {
    // String textToSend = textFieldController.text;
    // String textToSend = imran;
    Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => HomePage(text: textToSend,),
          builder: (context) => SubmitCoordinat( id: _selectedCompany.id , department: _selectedCompany.name, ),
        ));
  } */

}
