//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_deparment.dart';
import 'server_response.dart';
import 'collectionModel.dart';
import 'Users_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'networking.dart';
import 'question model.dart';
import 'dart:io';





class SubmitCoordinat extends StatefulWidget {
   String selectedCoordinat,department, secondname;
   var collectcor = new List();
   int id,secondid;
   SubmitCoordinat({ Key key,this.id, this.department, this.selectedCoordinat,this.secondid,this.secondname,this.collectcor }):super(key: key );


  @override
  _HomePageState createState() => _HomePageState();  //value
}
class _HomePageState extends State<SubmitCoordinat> {

  File imageFile;


  _openGallery(BuildContext context) async{

    // ignore: deprecated_member_use
    var picture =  await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();


  }
  _openCamera(BuildContext context) async{
    // ignore: deprecated_member_use
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
  }


@override
  void initState() {
    // TODO: implement initState

    super.initState();

    //getDatatoHelper();
  }

void  getDatatoHelper() async {
  NetworkHelper  networkHelper = NetworkHelper( 'https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/my%20data.json');
  var Question = await networkHelper.getData();
  print(Question);
  setState(()  {
  });
    return items = Question;
}
 // List<CollectionModel> itemss = CollectionModel<>
  var  items =  new List(); //new List();
  @override
  Widget build(BuildContext context)  {
    TextEditingController fieldContorller = TextEditingController();
    getDatatoHelper();



    int i = 0;
    return Scaffold(
      appBar: AppBar(
        // title: Text("Get location"),
        title: Text('Get Collection'),
      ),
      body: Container(
        child:Column(
         //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('SUBMIT COORDINATES',style: TextStyle(fontWeight: FontWeight.bold),),
                FlatButton(
                  //color: Colors.grey,
                  child: Text('Back',style: TextStyle(
                    decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown()));
                  },
                ),
              ],
            ),

            Container(
                child:   CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 65,
                 child: Center(child: Text(widget.selectedCoordinat,style: TextStyle(height: 1, fontSize: 60))),
                  ),
                )


            ),
          SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(right: 10,left: 40),
              child: _DecideImageView(),                                // dilog alert function calling here for camra nad gallery
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: Expanded(
                child: IconButton(
                  icon: Icon(Icons.camera_alt, size: 40, color: Colors.blueAccent,),
                  tooltip: 'Increase volume by 10%',
                  onPressed: () {
                    _showChoiceDialog(context);
                    print('Volume button clicked');
                  },
                ),

              ),
            ),

            Text(
              ' Coordinates Collected',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Divider(color: Colors.black),

            Text(
              'Tap on submit to submit coardinates or\n                 Cancel to go start back',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Divider(height: 20, color: Colors.black),
            // past here the quistionar

  if(items.isEmpty)
      CircularProgressIndicator(),

    Expanded(

      child:Container(

        height: 200,
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.green
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
       // padding: const EdgeInsets.only(right: 20.0,left:20,top: 10,bottom: 10),
        child:  ListView.builder(
         // itemCount: Data == null ? 0 :Data.length ,
          itemCount: items.length,
          itemBuilder: (context, index) {
           // CircularProgressIndicator();

            //_controllers.add(new TextEditingController());
            return

            ListTile(

              //  title: Text('${items[index].name}'),
             // title: Text(Data[index].name),
              title: Text("${items[i++]['question']}"),
              subtitle: TextField(
              //    controller: items[i++].fieldContorller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Awnser here',
                  )
              ),
            );
          },
        ),
      ),
    ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
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
                //FlatButton.icon(onPressed: null, icon: null, label: null),
                FlatButton(
                  child: Text("push"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    print('items ${widget.selectedCoordinat}');
                    print('dpaertment ${widget.department}');
                    print('second name ${widget.secondname}');
                    print('id ${widget.id}');
                    print('second id ${widget.secondid}');
                    print('collect coordinats ${widget.collectcor}');
                    print('image test  $imageFile');

                  },
                ),
                FlatButton(
                  child: Text("SUBMIT"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    _sendDataToServer(context);
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ServerResponse()));
                    //_sendDataToServer(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sendDataToServer (BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServerResponse(id: widget.id , value: widget.department, secondid:widget.secondid, secondname: widget.secondname, listOFCor: widget.collectcor),
        ));
  }

}


