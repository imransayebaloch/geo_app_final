import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_deparment.dart';
import 'submit_coodinates.dart';


/* class ServerResponse extends StatelessWidget {
   String value;
   int id;
   ServerResponse({Key key,this.id, this.value}):super(key: key );



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
}  */

class ServerResponse extends StatefulWidget {
  String value;
  int id;
  ServerResponse({Key key,this.id, this.value}):super(key: key );

   //  String department = "";
   // int id;
   //  ServerResponse({Key key, this.id, this.department}):super(key: key );
  // final String str ;
  // HomePage({ Key key,this.str }):super(key: key );
  //HomePage({ Key key,  this.str }):super(key: key );

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<ServerResponse> {
  //  String str = "";
  // ServerResponse({ Key key,this. }):super(key: key );



  @override
  Widget build(BuildContext context) {

    // str;

    return Scaffold(


      appBar: AppBar(

        title: Text('Server Response'),
      ),
      body: Container(

        child:Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Expanded(
             child: Center(child: Text("Id: "+ widget.id.toString())),
           ),
            Expanded( child:
              Center(child: Text('Value: ' + widget.value)),

            ),



            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(Icons.check,size: 100,color: Colors.green,),

            ),

            Padding(
              padding: const EdgeInsets.only(right: 15, top:30),
              child: Text(
                ' Server Response',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Divider(

                  color: Colors.black
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 0, top:10,bottom: 10),
              child: Text(
                'Collected Coordinates have been submitted \n                            successfully',
                style: TextStyle(fontWeight: FontWeight.bold),

              ),
            ),
            Divider(
                color: Colors.black
            ),

            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( child:
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: FlatButton(
                    child: Text("Back"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      print("imran");
                      print(widget.id);
                      print(widget.value);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown()));

                    },
                  ),
                ),


                ),

              ],
            ),

            //expended end here



          ],
        ),

      ),
    );

  }



}


