import 'package:dio/dio.dart';
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
import 'main.dart';
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
import 'image_screen.dart';

class SubmitCoordinat extends StatefulWidget {
  static  const  String id2 = "question_screen";
  String selectedCoordinat, department, secondname;
  var collectcor = new List();
  int id, secondid;
  SubmitCoordinat(
      {Key key,
      this.id,
      this.department,
      this.selectedCoordinat,
      this.secondid,
      this.secondname,
      this.collectcor})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(); //value
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
          QandAlist.add(QuestionOfftarget(
              id: element['id'],
              question: element['question'],
              type: element['type'],
              option_id: element['option_id']));
        });
      });
    }).catchError((error) {
      print("items error $error");
    });
    dbmanager.Questions1().then((value) {
      setState(() {
        value.forEach((element) {
          Qlist.add(QuestionTarget(
              id: element['id'],
              option_id: element['option_id'],
              options: element['options']));
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

  void getDatatoHelper() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/question_type.json');
    var Question = await networkHelper.getData();
    print(Question);
    setState(() {});
    return items = Question;
  }

  void getOptions() async {
    NetworkHelper networkHelper = NetworkHelper(
        "https://raw.githubusercontent.com/imransayebaloch/geo_app_final/Saud-tata/Options.json");
    var options = await networkHelper.getData();

    print("hello");
    print(options);
    setState(() {});
    return QuestionOptions = options;
  }

  void getHttp() async {
    try {
      var response = await Dio().get(
          "https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/pushData.json");
      print("dio get $response");
    } catch (e) {
      print(e);
    }
  }

  // List<CollectionModel> itemss = CollectionModel
  List<CollectionModel> textEdit =
      List<CollectionModel>.generate(5, (i) => CollectionModel("Question $i"));

  var items = new List();
  var listAwnsers = new List();
  var QuestionOptions = new List();

  @override
  Widget build(BuildContext context) {
    TextEditingController fieldContorller = TextEditingController();

    print("list size here1212${QandAlist.length}");
    if (QtargetOff == null) {
      CircularProgressIndicator();

      for (int i = 0; i < items.length; i++) {
        QuestionOfftarget st = new QuestionOfftarget(
            id: items[i]['id'],
            question: items[i]['question'],

            // awnser: textEdit[i].awnsers,
            type: items[i]['type'],
            option_id: items[i]['option_id']); //

        dbmanager
            .insertQuestionsOffline(st)
            .then((id) =>
                    //.clear(),
                    // _courseController.clear(),
                    //  print('Student Added to Db ${id} ${st.course}')
                    print('target test ${st.id} ${st.question}  ')
                // }
                )
            .catchError((error) {
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
    if (Qtarget == null) {
      CircularProgressIndicator();
      for (int i = 0; i < QuestionOptions.length; i++) {
        QuestionTarget st = new QuestionTarget(
            id: QuestionOptions[i]["id"],
            options: QuestionOptions[i]["options"],
            // awnser: textEdit[i].awnsers,
            option_id: QuestionOptions[i]["option_id"]); //

        dbmanager
            .insertQuestions(st)
            .then((id) =>

                    //.clear(),
                    // _courseController.clear(),

                    //  print('Student Added to Db ${id} ${st.course}')
                    print('Qtarget test ${st.options}')
                // }
                )
            .catchError((error) {
          i++;
        });
      }
    } else {
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
          title: Text('Survey'),
        ),
        body: Container(
          //child:  Expanded(

          // child:widget(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 10,),
              if (QandAlist
                  .isEmpty) //if there are no data then print the cercular progerss
                CircularProgressIndicator(),
              Expanded(
                child: Container(
                  height: 200,
                  width: 360,
                  child: ListView.builder(
                    // itemCount: Data == null ? 0 :Data.length ,
                    itemCount: QandAlist.length,
                    itemBuilder: (context, index) {
                      //   CircularProgressIndicator();
                      // if(QandAlist.isEmpty)
                      //   CircularProgressIndicator();
                      // print("${items[index]['type']}");
                      //_controllers.add(new TextEditingController());
                      switch (QandAlist[index].type) {
                        case "Single Awnsers":

//                        make new lists dynamically
                          var list1 = new List();
                          for (var i = 0; i < Qlist.length; i++) {
                            if (Qlist[i].option_id ==
                                QandAlist[index].option_id) {
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

                          return ListTile(
                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),

                            title: Text(QandAlist[index].question)
                            // FutureBuilder<List<awnserTarget>>(                     //This one for first dropdown
                            //     future: dbmanager.getAwnsers(),
                            //     builder: (BuildContext context,
                            //         AsyncSnapshot<List<awnserTarget>> snapshot) {
                            //       if (!snapshot.hasData) return CircularProgressIndicator();
                            //       print("question here check${snapshot.data[index].question}");
                            //       return Text(snapshot.data[index].question);
                            //     })
                            , //here i am showing the question from the server

                            subtitle: DropdownButtonFormField<String>(
                              value: textEdit[index].awnsers = dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              onChanged: (String newValue) {
                                textEdit[index].awnsers = newValue;
                                print("awnser123${textEdit[index].awnsers}");
                                setState(() => dropdownValue = newValue);
                              },
                              items: [
                                for (String i in list1)
                                  DropdownMenuItem(
                                    value: i,
                                    child: Text('$i'),
                                  )
                              ],
                            ),
//                        controller: textEdit[index].fieldContorller,
                          );

                        default:
                          return ListTile(
                            //  title: Text('${items[index].name}'),
                            // title: Text(Data[index].name),
                            title: Text(QandAlist[index].question)
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
                                )),
                          );
//                        print("bla bla");
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DropDown()));
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    /*  FlatButton(
                      color: Colors.blueAccent,
                      // color: Colors(Colors ,0x156562),
                      // backgroundColor: Color(0xffFDCF09),
                      child: Text('CANCEL' ,style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        //Navigator.pop(context);
                        Navigator.of(context).pop();
                        //  Navigator.push(context, MaterialPageRoute(builder: (_)=>  DropDown(),));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown()));
                        //_getCurrentLocation();
                      },
                    ),*/
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
                    ), */

                    Padding(
                      padding: const EdgeInsets.only(left: 135),
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          _sendDataToImageScreen(context);
                          _submitTarget(context);
                          //_sendDataToSubmitCoordinate(context);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //  ),
        ));
  }

  void _sendDataToServer(BuildContext context) {
    for (int i = 0; i < items.length; i++) {
      print("questions ${items[i]['question']}");
      print("awnsers1234${textEdit[i].awnsers}");
      print("awnsers${textEdit[i].fieldContorller.text}");
    }
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

  _controllertoawnser(int index) {
    textEdit[index].awnsers = textEdit[index].fieldContorller.text;
  }

  void _submitTarget(BuildContext context) {
    for (int i = 0; i < QandAlist.length; i++) {
      awnserTarget st = new awnserTarget(
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

  void _sendDataToImageScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageScreen(
              selectedCoordinat: widget.selectedCoordinat,
              id: widget.id,
              department: widget.department,
              secondid: widget.secondid,
              secondname: widget.secondname,
              collectcor: widget.collectcor),
        ));
  }
}
