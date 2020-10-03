import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_deparment.dart';
import 'server_response.dart';


/* class SubmitCoordinates extends StatelessWidget {
  String str= "";
 // SubmitCoordinates({Key key, this.str}):super(key: key );



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

class SubmitCoordinat extends StatefulWidget {
   String selectedCoordinat,department;
   int id;
   SubmitCoordinat({ Key key,this.id, this.department, this.selectedCoordinat }):super(key: key );


  @override
  _HomePageState createState() => _HomePageState();  //value
}
class _HomePageState extends State<SubmitCoordinat> {
    // String selectedCoordinat="";
    // _HomePageState({ Key key,this.selectedCoordinat }):super(key: key );
  // _HomePageState({ Key key,this.str }):super(key: key );



  @override
  Widget build(BuildContext context) {


    // str;

    return Scaffold(

      appBar: AppBar(
        // title: Text("Get location"),
        title: Text('Get Collection'),
      ),
      body: Container(

        child:Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
               //Text(str),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                children: [
                  Text('SUBMIT COORDINATES',style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 100,),
                    child: FlatButton(
                      color: Colors.grey,


                      child: Text('Back'),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown()));

                      },
                    ),
                  ),
                ],
              ),
            ),




            // Column(
            //   children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(

               child:   CircleAvatar(
                    radius: 70,
                    backgroundColor: Color(0xffFDCF09),
                    child: CircleAvatar(
                      radius: 65,
                   child: Center(child: Text(widget.selectedCoordinat,style: TextStyle(height: 1, fontSize: 60))),
                   //   backgroundColor: Color(0x82d3c7),
                     // backgroundImage: AssetImage('images/batman.jpg'),
                    ),

                  )



              ),
            ),
            //   SizedBox.fromSize()



            Padding(
              padding: const EdgeInsets.only(right: 15, top:30),
              child: Text(
                ' Coordinates Collected',
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
                'Tap on submit to submit coardinates or\n                 Cancel to go start back',
                style: TextStyle(fontWeight: FontWeight.bold),

              ),
            ),
            Divider(
                color: Colors.black
            ),

            Padding(
              padding: const EdgeInsets.only(top: 100,left: 40),

              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child:
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: FlatButton(
                      color: Colors.blueAccent,
                       // color: Colors(Colors ,0x156562),
                     // backgroundColor: Color(0xffFDCF09),
                      child: Text('CANCEL'),
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
                      child: Text("SUBMIT"),
                      color: Colors.blueAccent,
                      onPressed: () {
                        print('submit coor test');
                        print(widget.id);
                        print(widget.department);
                        print(widget.selectedCoordinat);
                        _sendDataToServer(context);
                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => ServerResponse()));
                        //_sendDataToServer(context);
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

  void _sendDataToServer (BuildContext context) {
    // String textToSend = textFieldController.text;
    // String textToSend = imran;
    Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => HomePage(text: textToSend,),
          builder: (context) => ServerResponse(id: widget.id , value: widget.department,),
        ));
  }

}


