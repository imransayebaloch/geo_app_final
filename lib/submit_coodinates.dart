
//import 'dart:html';

//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/imran%20sayed/AndroidStudioProjects/geo_app_final/lib/Question%20Model/Question_data.dart';
//import 'package:geo_app_final/question%20model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'DBmanager/dbmanager.dart';
import 'Main/main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_lat_long.dart';
import 'server_response.dart';
import 'Collection Model/collectionModel.dart';
import 'DropDown Model/Dropdown_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'URL Network Helpher/networking.dart';
//import 'question model.dart';
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
  final DbStudentManager dbmanager = new DbStudentManager();
  // db

  awnserTarget target;
  QuestionOfftarget QtargetOff;
  QuestionTarget Qtarget;
  List<QuestionOfftarget> QandAlist = new List();
  List<QuestionTarget> Qlist = new List();
  File imageFile;
  List type;
  Users _currentUser;



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
      Image.file( imageFile,width: 200, height: 100);
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

  final myController = TextEditingController();
  final myTest = TextEditingController();

//CollectionModel()
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    myTest.dispose();
    CollectionModel(null).fieldContorller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getOptions();
    getDatatoHelper();
    dbmanager.query().then((value) {
      setState(() {
        value.forEach((element) {
          QandAlist.add(QuestionOfftarget(id: element['id'],question: element['question'],type: element['type'],option_id: element['option_id']));

        });
      });
    }).catchError((error) {
      print("items error $error");
    });
    dbmanager.Questions1().then((value) {
      setState(() {
        value.forEach((element) {
          Qlist.add(QuestionTarget(id: element['id'],option_id: element['option_id'],options: element['options']));

        });
      });
    }).catchError((error) {
      print("items error $error");
    });

    myController.addListener(_printLatestValue);
    myTest.addListener(_printLatestValue);
    CollectionModel(null).fieldContorller.addListener(_printLatestValue);

    //getDatatoHelper();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
    print("my test: ${myTest.text}");
    print("field controller: ${CollectionModel(null).fieldContorller.text}");

  }

  void  getDatatoHelper() async {
    NetworkHelper  networkHelper = NetworkHelper( 'https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/question_type.json');
    var Question = await networkHelper.getData();
    print(Question);
    setState(()  {
    });
    return items = Question;
  }
  // final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  // QuestionC _currentQuestion;
  // Future<List<QuestionC>> _fetchUsers() async {
  //   var response = await http.get(uri);
  //
  //   if (response.statusCode == 200) {
  //     final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //     List<Users> listOfProjects = items.map<Users>((json) {
  //       return Users.fromJson(json);
  //     }).toList();
  //
  //     return listOfUsers;
  //   } else {
  //     throw Exception('Failed to load internet');
  //   }
  // }
  void getOptions() async {
    NetworkHelper  networkHelper = NetworkHelper("https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/Options.json");
    var options = await networkHelper.getData();

    print("hello");
    print(options);
    setState(()  {
    });
    return QuestionOptions = options;

  }
  // List<CollectionModel> itemss = CollectionModel
  List<CollectionModel> textEdit =  List<CollectionModel>.generate(5, (i) => CollectionModel("Question $i"));

  var  items =  new List();
  var listAwnsers = new List();
  var  QuestionOptions =  new List();


  @override
  Widget build(BuildContext context)  {
    TextEditingController fieldContorller = TextEditingController();

    print("list size here1212${QandAlist.length}");
    if (QtargetOff==null ) {
      CircularProgressIndicator();
      for (int i = 0; i < items.length; i++) {
        QuestionOfftarget st = new QuestionOfftarget (
            id: items[i]['id'],
            question: items[i]['question'],

            // awnser: textEdit[i].awnsers,
            type: items[i]['type'],
            option_id: items[i]['option_id']
        ); //

        dbmanager.insertQuestionsOffline(st).then((id) =>

        //.clear(),
        // _courseController.clear(),

        //  print('Student Added to Db ${id} ${st.course}')
        print('target test ${st.id} ${st.question}  ')
          // }
        ).catchError((error) {
          throw i++;
        });


      }


    }
//     else {
// //      for (int i = 0; i < listOfUsers.length; i++) {
//
//         // _nameController.clear(),
//         // _courseController.clear(),
//         // target = null;
//
//     }
    if (Qtarget==null ) {
      CircularProgressIndicator();
      for (int i = 0; i < QuestionOptions.length; i++) {
        QuestionTarget st = new QuestionTarget (
            id:  QuestionOptions[i]["id"],
            options: QuestionOptions[i]["options"],
            // awnser: textEdit[i].awnsers,
            option_id: QuestionOptions[i]["option_id"]); //

        dbmanager.insertQuestions(st).then((id) =>

        //.clear(),
        // _courseController.clear(),

        //  print('Student Added to Db ${id} ${st.course}')
        print('Qtarget test ${st.options}')
          // }
        ).catchError((error) {
          i++;
        });
      }


    }else{
      // Qtarget=null;
    }


    // List<String> list = dbmanager.query() as List<String>;
    // print("check size here1234 ${list.length}");
    print("list size here1212${QandAlist.length}");
    dbmanager.getAwnsers();
//for(var t=0;t<QuestionOptions.length;t++){
//  print("options${QuestionOptions[t]["options"].toString()}");
//}


    int i = 0;
    return Scaffold(
      appBar: AppBar(
        // title: Text("Get location"),
        title: Text('Get Collection'),
      ),
      body: Container(
        child:Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('SUBMIT COORDINATES',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
   /*             FlatButton(
                  //color: Colors.grey,
                  child: Text('Back',style: TextStyle(
                      decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                  onPressed: (){
                    print("hello type ${QandAlist[1].type.toString()}");
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown()));
                  },
                ),*/
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
            Text(
              ' Coordinates Collected',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                IconButton(
                  icon: Icon(Icons.camera_alt, size: 40, color: Colors.blueAccent,),
                  tooltip: 'camera ',
                  onPressed: () {
                    _showChoiceDialog(context);
                    print('Volume button clicked');
                  },
                ),
                _DecideImageView(),
              ],
            ),



            Divider(color: Colors.black),

            Text(
              'Tap on submit to submit coardinates or\n                 Cancel to go start back',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Divider(height: 20, color: Colors.black),
            // past here the quistionar

            if(QandAlist.isEmpty)               //if there are no data then print the cercular progerss
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
                  itemCount: QandAlist.length,
                  itemBuilder: (context, index) {
                    // CircularProgressIndicator();

                    // print("${items[index]['type']}");
                    //_controllers.add(new TextEditingController());
                    switch(QandAlist[index].type){
                      case "Single Awnsers":

//                        make new lists dynamically
                        var list1 = new List();
                        for(var i=0;i<Qlist.length;i++) {
                          if (Qlist[i].option_id==QandAlist[index].option_id){
                            // print("items here123 ${items[index]["option_id"]}");
                            list1.add(Qlist[i].options);
                            print("list options here ${Qlist[i].options}");
                          }
                          // print("object${QandAlist[i].question}");
                        }

                        String dropdownValue = list1.first;
//                        listAwnsers= new List();
//                        listAwnsers.add(dropdownValue);
//                         FutureBuilder<List<awnserTarget>>(                     //This one for first dropdown
//                             future: dbmanager.getAwnsers(),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<List<awnserTarget>> snapshot) {
//                               if (!snapshot.hasData) return CircularProgressIndicator();
//                               print("motherfucker ${snapshot.data.tos()}");
//                               return Text(target.question[index]);
//                             });

                        return

                          ListTile(

                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),

                            title:Text(QandAlist[index].question)
                            // FutureBuilder<List<awnserTarget>>(                     //This one for first dropdown
                            //     future: dbmanager.getAwnsers(),
                            //     builder: (BuildContext context,
                            //         AsyncSnapshot<List<awnserTarget>> snapshot) {
                            //       if (!snapshot.hasData) return CircularProgressIndicator();
                            //       print("question here check${snapshot.data[index].question}");
                            //       return Text(snapshot.data[index].question);
                            //     })
                            , //here i am showing the question from the server

                            subtitle:DropdownButtonFormField<String>(
                              value:textEdit[index].awnsers=dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,

                              style: TextStyle(
                                  color: Colors.deepPurple
                              ),

                              onChanged: (String newValue){
                                textEdit[index].awnsers=newValue;
                                print("awnser123${textEdit[index].awnsers}");
                                setState(() => dropdownValue = newValue);},
                              items: [
                                for (String i in list1) DropdownMenuItem(
                                  value: i,
                                  child: Text('$i'),
                                )
                              ],
                            ),
//                        controller: textEdit[index].fieldContorller,
                          );
                      default:
                        return
                          ListTile(

                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),
                            title:Text(QandAlist[index].question)
                            // FutureBuilder<List<awnserTarget>>(                     //This one for first dropdown
                            //     future: dbmanager.getAwnsers(),
                            //     builder: (BuildContext context,
                            //         AsyncSnapshot<List<awnserTarget>> snapshot) {
                            //       if (!snapshot.hasData) return CircularProgressIndicator();
                            //       print("question here check${snapshot.data[index].question}");
                            //       return Text(snapshot.data[index].question);
                            //     })
                            , //here i am showing the question from the server

                            subtitle: TextField(
                                controller: textEdit[index].fieldContorller,
                                onSubmitted: _controllertoawnser(index),
//                                onChanged: (),
//                                onChanged: (text),
                                // controller: items[i++].myController,
                                // controller: myTest,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your Close Awnser here now',
                                )
                            ),
                          );
//                        print("bla bla");
                    }
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
       /*         FlatButton(
                  child: Text("push"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    print(_printLatestValue());
                    print('items ${widget.selectedCoordinat}');
                    print('dpaertment ${widget.department}');
                    print('second name ${widget.secondname}');
                    print('id ${widget.id}');
                    print('second id ${widget.secondid}');
                    print('collect coordinats ${widget.collectcor}');
                    print('image test  $imageFile');
                    //print('edit text  ${CollectionModel(null).fieldContorller.text}');
                    print("controller ${textEdit}");
                    print("type my friend${dbmanager.queryQQQ()}");
                    print("type my friend${dbmanager.queryQQ()}");
                    print("type my count${dbmanager.queryoption()}");
                    print("type my count${dbmanager.query()}");

                  },
                ),*/

                FlatButton(
                  child: Text("SUBMIT"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    _submitTarget(context);
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
    for (int i=0;i<items.length;i++ ){

      print("questions ${items[i]['question']}");
      print("awnsers1234${textEdit[i].awnsers}");
      print("awnsers${textEdit[i].fieldContorller.text}");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServerResponse(id: widget.id , value: widget.department, secondid:widget.secondid, secondname: widget.secondname, listOFCor: widget.collectcor),
        ));
  }

  _controllertoawnser(int index) {
    textEdit[index].awnsers=textEdit[index].fieldContorller.text;

  }

  void _submitTarget(BuildContext context) {

    for (int i = 0; i < QandAlist.length; i++) {
      awnserTarget st = new awnserTarget (
          assetid: widget.id,
          question: QandAlist[i].question,
          awnser: textEdit[i].awnsers,
          type: QandAlist[i].type); //

      dbmanager.insertAwnser(st).then((id) =>

      //.clear(),
      // _courseController.clear(),

      //  print('Student Added to Db ${id} ${st.course}')
      print('target test ${st.assetid} ${st.awnser} ${st.question}  ')
        // }
      );

    }
  }
  void _getQuestions() {
    super.initState();
    dbmanager.query().then((value) {
      setState(() {
        value.forEach((element) {
          // QandAlist.add(awnserTarget(type: element['type']));

        });
      });
    }).catchError((error) {
      print("items error $error");
    });
  }

}






















/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dbmanager.dart';
import 'main.dart';
import 'dart:async';
import 'package:circle_list/circle_list.dart';
import 'collect_lat_long.dart';
import 'server_response.dart';
import 'collectionModel.dart';
import 'Dropdown_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'networking.dart';
//import 'question model.dart';
import 'dart:io';
//import 'main3.dart';





class SubmitCoordinat extends StatefulWidget {
  String selectedCoordinat,department, secondname;
  var collectcor = new List();
  int id,secondid;
  SubmitCoordinat({ Key key,this.id, this.department, this.selectedCoordinat,this.secondid,this.secondname,this.collectcor }):super(key: key );


  @override
  _HomePageState createState() => _HomePageState();  //value
}
class _HomePageState extends State<SubmitCoordinat> {
  final DbStudentManager dbmanager = new DbStudentManager();
  awnserTarget target;

  File imageFile;
  Users _currentUser;


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
      Image.file( imageFile,width: 200, height: 100);
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

  final myController = TextEditingController();
  final myTest = TextEditingController();

//CollectionModel()
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    myTest.dispose();
    CollectionModel(null).fieldContorller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    myController.addListener(_printLatestValue);
    myTest.addListener(_printLatestValue);
    CollectionModel(null).fieldContorller.addListener(_printLatestValue);

    //getDatatoHelper();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
    print("my test: ${myTest.text}");
    print("field controller: ${CollectionModel(null).fieldContorller.text}");

  }

  void  getDatatoHelper() async {
    NetworkHelper  networkHelper = NetworkHelper( 'https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/question_type.json');
    var Question = await networkHelper.getData();
    print(Question);
    setState(()  {
    });
    return items = Question;
  }
  void getOptions() async {
    NetworkHelper  networkHelper = NetworkHelper("https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/Options.json");
    var options = await networkHelper.getData();

    print("hello");
    print(options);
    setState(()  {
    });
    return QuestionOptions = options;

  }
  // List<CollectionModel> itemss = CollectionModel
  List<CollectionModel> textEdit =  List<CollectionModel>.generate(5, (i) => CollectionModel("Question $i"));

  var  items =  new List();
  var listAwnsers = new List();
  var  QuestionOptions =  new List();

  @override
  Widget build(BuildContext context)  {
    TextEditingController fieldContorller = TextEditingController();
    getOptions();
    getDatatoHelper();
//for(var t=0;t<QuestionOptions.length;t++){
//  print("options${QuestionOptions[t]["options"].toString()}");
//}


    int i = 0;
    return Scaffold(
      appBar: AppBar(
        // title: Text("Get location"),
        title: Text('Get Collection'),
      ),
      body: Container(
        child:Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('SUBMIT COORDINATES',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
          /*      FlatButton(
                  //color: Colors.grey,
                  child: Text('Back',style: TextStyle(
                      decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown()));
                  },
                ),*/
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
            Text(
              ' Coordinates Collected',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                IconButton(
                  icon: Icon(Icons.camera_alt, size: 40, color: Colors.blueAccent,),
                  tooltip: 'camera ',
                  onPressed: () {
                    _showChoiceDialog(context);
                    print('Volume button clicked');
                  },
                ),
                _DecideImageView(),
              ],
            ),



            Divider(color: Colors.black),

            Text(
              'Tap on submit to submit coardinates or\n                 Cancel to go start back',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Divider(height: 20, color: Colors.black),
            // past here the quistionar

            if(items.isEmpty)               //if there are no data then print the cercular progerss
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
                    switch(items[index]["type"]){
                      case "Single Awnsers":

//                        make new lists dynamically
                        var list1 = new List();
                        for(var i=0;i<QuestionOptions.length;i++) {
                          if (QuestionOptions[i]["option_id"].contains(items[index]["option_id"]))
                            list1.add(QuestionOptions[i]["options"]);
                          print("list options here ${QuestionOptions[i]["options"]}");
                        }
                        String dropdownValue
                        = list1.first;
//                        listAwnsers= new List();
//                        listAwnsers.add(dropdownValue);

                        return

                          ListTile(

                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),
                            title: Text("${items[index]['question']}"), //here i am showing the question from the server

                            subtitle:DropdownButtonFormField<String>(
                              value:textEdit[index].awnsers=dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,

                              style: TextStyle(
                                  color: Colors.deepPurple
                              ),

                              onChanged: (String newValue){
                                textEdit[index].awnsers=newValue;
                                print("awnser123${textEdit[index].awnsers}");
                                setState(() => dropdownValue = newValue);},
                              items: [
                                for (String i in list1) DropdownMenuItem(
                                  value: i,
                                  child: Text('$i'),
                                )
                              ],
                            ),
//                        controller: textEdit[index].fieldContorller,
                          );
                      default:
                        return
                          ListTile(

                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),
                            title: Text("${items[index]['question']}"), //here i am showing the question from the server

                            subtitle: TextField(
                                controller: textEdit[index].fieldContorller,
                                onSubmitted: _controllertoawnser(index),
//                                onChanged: (),
//                                onChanged: (text),
                                // controller: items[i++].myController,
                                // controller: myTest,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your Close Awnser here',
                                )
                            ),
                          );
//                        print("bla bla");
                    }
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
          /*      FlatButton(
                  child: Text("push"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    print(_printLatestValue());
                    print('items ${widget.selectedCoordinat}');
                    print('dpaertment ${widget.department}');
                    print('second name ${widget.secondname}');
                    print('id ${widget.id}');
                    print('second id ${widget.secondid}');
                    print('collect coordinats ${widget.collectcor}');
                    print('image test  $imageFile');
                    //print('edit text  ${CollectionModel(null).fieldContorller.text}');
                    print("controller ${textEdit}");

                  },
                ),*/
                FlatButton(
                  child: Text("SUBMIT"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    _submitTarget(context);
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
    for (int i=0;i<items.length;i++ ){

      print("questions ${items[i]['question']}");
      print("awnsers1234${textEdit[i].awnsers}");
      print("awnsers${textEdit[i].fieldContorller.text}");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServerResponse(id: widget.id , value: widget.department, secondid:widget.secondid, secondname: widget.secondname, listOFCor: widget.collectcor),
        ));
  }

  _controllertoawnser(int index) {
    textEdit[index].awnsers=textEdit[index].fieldContorller.text;

  }

  void _submitTarget(BuildContext context) {
    if (target == null) {
      for (int i = 0; i < items.length; i++) {
        awnserTarget st = new awnserTarget (
            assetid: widget.id, question: items[i]['question'],awnser:textEdit[i].awnsers);//

        dbmanager.insertAwnser(st).then((id) =>

          //.clear(),
          // _courseController.clear(),

          //  print('Student Added to Db ${id} ${st.course}')
        print('target test ${st.assetid} ${st.awnser} ')
          // }
        );
      }
    }
  }

}  */