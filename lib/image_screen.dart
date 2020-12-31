// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'Login form/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'server_response.dart';
import 'package:geo_app_final/Main/main.dart';
import 'package:http/http.dart' as http;

class ImageScreen extends StatefulWidget {
  String selectedCoordinat, department, secondname;
  var collectcor = new List();
  int id, secondid;
  ImageScreen(
      {Key key,
      this.id,
      this.department,
      this.selectedCoordinat,
      this.secondid,
      this.secondname,
      this.collectcor})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<ImageScreen> {
  Response response;
  Dio dio = new Dio();

  void getHttp() async {
    //  try {
    http.Response response = await http.get(
        'https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/myAPI');
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      var latitude = jsonDecode(data)['coord']['lat'];
      print('my get $longitude');
      //print('my long $data');
    }
//      response = await dio.get("https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/qda%20project");
//      print("dio data ${response.data.toString()}");
// //Optionally the request above could also be done as
//       response = await dio.get("/test", queryParameters: {"id": 1, "name": "QDA"});
//       print("dio b test${response.data.toString()}");
//
//
//       Response response = await Dio().get("https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/my%20data.json");
//       print("dio get $response");
//     } catch (e) {
//       print(e);
//     }
  }

  File imageFile;

  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _DecideImageView() {
    if (imageFile == null) {
      return Container(
          height: 200,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 90),
            child: Text(
              'No image selected , please tap on \n    camera button insert an image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));

      //   Padding(
      //   padding: const EdgeInsets.only(left: 120,top: 70),
      //   child: Text('No image selected'),
      // );
    } else {
      return
          // Image.file(
          //     imageFile,width: 200, height: 100,
          //   fit: BoxFit.cover,
          // );
          //  BackdropFilter(
          //  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          //    child:
          Padding(
        padding: const EdgeInsets.only(right: 80),
        child: new Container(
          height: 200,
          width: 250,

          decoration: new BoxDecoration(
            //this is not accepted becuse Image.file is not ImageProvider
            image: new DecorationImage(
              image: new FileImage(imageFile),
              //  fit: BoxFit.cover
            ),

            borderRadius: new BorderRadius.all(new Radius.circular(30)),
          ),
          // child: Center(child: new CircularProgressIndicator(backgroundColor: Colors.deepPurpleAccent,)),
        ),
      );
      //    );

    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Make a choice'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              )));
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" ", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            // FlatButton(
            //   onPressed: () {
            //     _sendDataToServer(context);
            //
            // //    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            //   },
            //   child: Text("done", style: TextStyle(color: Colors.white)),
            // ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              // Center(child: Text("Main Page")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //   Image(image: AssetImage('/default_image.png'),),
                  // Image.asset('assets/default_image.png'),
                  //  AssetImage assetImag = AssetImage('assetes/de'),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SUBMIT COORDINATES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              Container(
                  child: CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xffFDCF09),
                child: CircleAvatar(
                  radius: 65,
                  child: Center(
                      child: Text(widget.selectedCoordinat,
                          style: TextStyle(height: 1, fontSize: 60))),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                ' Coordinates Collected',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(color: Colors.black),
              ),

              Text(
                'Tap on submit to submit coordinates or\n                 Cancel to go start back',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // GestureDetector(
                  //   onTap: () {}, // handle your image tap here
                  //   child:  Image.asset(
                  //     'assets/default_image.png',
                  //     fit: BoxFit.cover, // this is the solution for border
                  //     width: 110.0,
                  //     height: 110.0,
                  //   ),
                  // ),

                  Container(
                    // height: 100,
                    // width: 200,
                    //    decoration: BoxDecoration(
                    //   border: Border.all(
                    //       color: Colors.green
                    //   ),
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //   color: Colors.redAccent,
                    // ),
                    child: _DecideImageView(),
                  ), //===============past here
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            //Navigator.pop(context);
                            Navigator.of(context).pop();
                            //  Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown(),));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DropDown()));
                            //_getCurrentLocation();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              _sendDataToServer(context);
                              //Navigator.pop(context);
                              // Navigator.of(context).pop();
                              // //  Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown(),));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown()));
                              //_getCurrentLocation();
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor:
                              Colors.blue, //const Color(0xff03dac6),
                          foregroundColor: Colors.white,
                          mini: true,
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          child: Icon(Icons.camera_alt),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        //   drawer: Drawer(),
        );
  }

  void _sendDataToServer(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServerResponse(
              id: widget.id,
              value: widget.department,
              secondid: widget.secondid,
              secondname: widget.secondname,
              listOFCor: widget.collectcor),
        ));
  }
}
