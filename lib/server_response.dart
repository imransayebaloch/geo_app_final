import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'Main/main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_lat_long.dart';
import 'questions.dart';
import 'DropDown Model/Dropdown_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  String value, secondname;
  int id, secondid;
  var listOFCor = new List();
  ServerResponse(
      {Key key,
      this.id,
      this.value,
      this.secondid,
      this.secondname,
      this.listOFCor})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ServerResponse> {
  File imageFile;

/*
  _openGallery(BuildContext context) async{

    var picture =  await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();


  }
  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _DecideImageView(){
    if( imageFile == null) {
      return Text('No image selected');
    }else{ return
      Image.file( imageFile,width: 80, height: 80);
    }
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
          title: Text('Make a choice'),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: (){
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: (){
                      _openCamera(context);
                    },
                  )
                ],
              )
          )
      );
    }
    );
  }  */

  // Future<Users> getApiCallUsingDio () async{
  //   Dio dio= Dio();
  //   final  response = await Dio().post("https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json", data: {"id": 1, "name": "imran"});
  //   if (response.statusCode == 200){
  //      var data =response.data;
  //      ret
  //   }

  // print('tesing API $response');

  /* void getHttp() async {
    try {
    //  Response response = await Dio().get("https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json");
    //   Future<Users> getApiCallUsingDio () async{
    //   Dio dio= Dio();
    //   final  response = await Dio().post("https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json", data: {"id": 1, "name": "imran"});
    //   print('tesing API $response');

    }
   //  Response response = await Dio().post("https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json", data: {"id": 1, "name": "imran"});
    // headers:{"",""}

    } catch (e) {
      print(e);
    }  */
  //}
/*
  BaseOptions options = new BaseOptions(
    baseUrl: "https://www.xx.com/api",
    connectTimeout: 5000,
    receiveTimeout: 3000,);
  Dio dio = new Dio(options);
//
  Map<String, String> params = Map();
  Users['username'] = '6388';
  params['password'] = '123456';
//
  response = await dio.post("/login", data: FormData.fromMap(params));  */

/*  final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  Users _currentUser;
  Future<List<Users>> _fetchUsers() async {
    var response = await http.post(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server Response'),
      ),
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*       Expanded(
             child: Center(child: Text("Project Id : "+ widget.id.toString())),
           ),
            Expanded( child:
              Center(child: Text('Project name : ' + widget.value)),
            ),

            Expanded(
              child: Center(child: Text("Target Id  : "+ widget.secondid.toString())),
            ),
            Expanded( child:
            Center(child: Text('Target name: ' + widget.secondname)),
            ),

                */

            //  Expanded( child:
            // // Center(child: Text('list : ' + widget.collectcor)),
            //  ),

            Row(
              children: [
                // _DecideImageView(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 130),
                  child: Icon(
                    Icons.check,
                    size: 100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: Text(
                ' Server Response',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Divider(color: Colors.black),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 0, top: 10, bottom: 10),
              child: Text(
                'Collected Coordinates have been submitted \n                            successfully',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: Colors.black),
            /*    Container(
          height: 100,
          width: 280,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
       child:
           Expanded(
             child:
             ListView(
               children: <Widget>[
                 if (widget.listOFCor != null)
                   for(int i = 0; i < widget.listOFCor.length; i++)
                     Center(
                       child: Text(("Position: ${i + 1} LAT: ${widget.listOFCor[i]
                           .latitude}, LNG: ${widget.listOFCor[i].longitude}"),style: TextStyle(fontSize: 14),
                       ),
                     ),
               ],
             ),
           ),
    ),

             Row(

               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 10,left:80),
                   child: Expanded(
                    child: FlatButton(
                      //padding: EdgeInsets.only(top: 0),
                       child: Text('Push Me'),
                      color: Colors.lightGreen,
                      onPressed: (){
                        print("list of id${widget.id}");
                        print("list of second name${widget.secondname}");
                        print("list of cor${widget.listOFCor}");

                      },
                     ),
                   ),
                 ),

                 Padding(
                   padding: const EdgeInsets.only(top: 10,left: 20),
                   child: Expanded(
                     child: IconButton(
                       icon: Icon(Icons.camera_alt, size: 40, color: Colors.blueAccent,),
                       tooltip: 'Increase volume by 10%',
                       onPressed: () {
                       //  _showChoiceDialog(context);
                         print('Volume button clicked');
                         },
                     ),

                   ),
                 ),


               ],
             ),   */
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 60, right: 60, top: 220),
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        // _sendDataToServer(context);
                        //Navigator.pop(context);
                        // Navigator.of(context).pop();
                        // //  Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown(),));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DropDown()));
                        //_getCurrentLocation();
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // FlatButton(
                    //   child: Text("Back", style: TextStyle(color: Colors.white),),
                    //   color: Colors.blueAccent,
                    //   onPressed: () {
                    //     print('list cheking ${widget.listOFCor}');
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown()));
                    //   },
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
