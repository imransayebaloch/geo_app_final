import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_app_final/collect_deparment.dart' as select;
import 'package:geo_app_final/collect_deparment.dart';
import 'package:geo_app_final/secoundDbManager.dart';
import 'package:geo_app_final/your_location.dart' as location;
import 'package:sqflite/sqflite.dart';
import 'your_location.dart';
//import 'server_response.dart';
import 'package:http/http.dart' as http;
import 'function_of_ropDown.dart';
import 'dart:convert';
import 'Users_data.dart';
import 'dbmanager.dart';
import 'package:connectivity/connectivity.dart';
import 'secoundDbManager.dart';
import 'Project_data.dart';

void main()
=> runApp(
    DropDown()
);

class DropDown extends StatefulWidget {
  DropDown() : super();
  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
   //   debugShowCheckedModeBanner: false,
      home:  Location(),
    );
  }
}

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}
//List<Users> listOfUsers;
class _LocationState extends State<Location> {

  // String _connectionStatus = 'Unknown';
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;



  final DbStudentManager dbmanager = new DbStudentManager();

//  final DbProjectManager projectmanager = new DbProjectManager();
  // final _nameController = TextEditingController();
  // final _courseController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Target target;
  List<QuestionOfftarget> QandAlist = new List();
  ProjectTarget ptarget;
//  Project project, dbProjectValue;
  List<Target> studlist;
  List<ProjectTarget> projlist;
  int updateIndex, updateIndexPro;
   List<Users> listOfUsers ;
  List<Users> secoundlistOfUsers ;
  Target dbvalue;
  ProjectTarget dbvalueproj;



  @override
  void initState() {
    super.initState();
   // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // this.getJsonData();
_sendData();
  }

  /*

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  } */

  final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  Users _currentUser;
  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      listOfUsers  = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Second URI  ================================
  final seconduri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/qda.json';
  Users _secondcurrentUser;
  Future<List<Users>> _secondfetchUsers() async {
    var response = await http.get(seconduri);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      secoundlistOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return secoundlistOfUsers;

//      return SecoundlistOfUsers;


    } else {
      throw Exception('Failed to load internet');
    }
  }


  Widget potrate(){
    return  Container(
      child: Center(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //this is first dropdown
            // Padding(
            //   padding: const EdgeInsets.only(right: 150,top: 20),
            //   child: Text("SELECT PROJECT"),
            // ),
            // testing dropdown
            //==========================================================================================
          //  Text("connection test $_connectionStatus"),
            FutureBuilder<List<ProjectTarget>>(                     //This one for first dropdown
                future: dbmanager.getProjectList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProjectTarget>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<ProjectTarget>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<ProjectTarget>(
                      child: Text(user.name),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (ProjectTarget value) {
                      setState(() {
                        dbvalueproj = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,

                    hint: dbvalueproj != null
                        ? Text("" +
                        dbvalueproj.name )
                        : Text("No project selected"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }),


            SizedBox(height: 5.0),


            //==========================================================================================

            Divider(
              color: Colors.black,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 150),
            //   child: Text('SELECT TARGET'),
            // ),
            FutureBuilder<List<Target>>(                     //This one for first dropdown
                future: dbmanager.getStudentList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Target>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<Target>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<Target>(
                      child: Text(user.name),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (Target value) {
                      setState(() {
                        dbvalue = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,

                    hint: dbvalue != null
                        ? Text("" +
                        dbvalue.name )
                        : Text("No Target selected"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }),


/*
           FutureBuilder<List<Users>>(
                future: _fetchUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Users>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<Users>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<Users>(
                      child: Text(user.name),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (Users value) {
                      setState(() {
                        _secondcurrentUser = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,

                    hint: _secondcurrentUser != null
                        ? Text("" +
                        _secondcurrentUser.name )
                        : Text("No Target selected"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }), */


            SizedBox(height: 20.0),
            _secondcurrentUser != null
                ? Text("Name: " +
                _secondcurrentUser.name )
                : Text("No Target selected"),

            Divider(
                color: Colors.black
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10, top:20),
              child: Text(
                'Tap on  Start to begin collecting coordinate or\n                 aginst selected project & target',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),


       /*     Expanded(
              child: FutureBuilder<List<Project>>(
                  future: dbmanager.getProjectList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Project>> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return DropdownButton<Project>(
                      items: snapshot.data
                          .map((user) => DropdownMenuItem<Project>(
                        child: Text(user.namePro),
                        value: user,
                      ))
                          .toList(),
                      onChanged: (Project value) {
                        setState(() {
                          dbProjectValue = value;
                        });
                      },
                      isExpanded: false,
                      //value: _currentUser,

                      hint: dbvalue != null
                          ? Text("" +
                          dbProjectValue.namePro )
                          : Text("No Target selected"),//Text('select Target'+_secondcurrentUser.name),

                    );
                  }),), */

            Container(
              margin: const EdgeInsets.only(top: 100.0),
              child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  //padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: (){
//                    print('second user ${_secondcurrentUser.name}');
                    _sendDataToSecondScreen(context);
                  },
                  child: Text(
                    "Start",
                  )
              ),
            )    , //staert button

            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                onPressed: (){
                  // dbmanager.query();
                  // print("query questions${dbmanager.query()}");
                  _submitTarget(context);
                  _submitProject(context);
            //  projectmanager.openDbProject();
              //    _submitProject(context);
               //   dbmanager.getStudentList();

//                  print('project checkced $listOfUsers $secoundlistOfUsers');
                },
                child: Text(
                  "DB Test",
                )
            ),

            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,

                splashColor: Colors.blueAccent,
                onPressed: (){
                  print("hello");
                  int id=24;

                  dbmanager.deleteStudent(id);

                  setState(() {
                   // studlist.removeAt(id);
                  });
                  print('db checked ');
                },
                child: Text(
                  "DB Detete",
                )
            ),  //staert butt

        /*    Expanded(
              child: FutureBuilder<List<Target>>(                     //This one for first dropdown
                future: dbmanager.getStudentList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Target>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<Target>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<Target>(
                      child: Text(user.name),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (Target value) {
                      setState(() {
                        dbvalue = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,

                    hint: dbvalue != null
                        ? Text("" +
                        dbvalue.name )
                        : Text("No Target selected"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }),),
                        */                                      //This is second drop down






          ],
        ),
      ),
    );
  }    //===============

  Widget landscape(){
   /// its for landscape screen
  }

  // @override
  // void initState() {
  //   super.initState();
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  //  // this.getJsonData();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("First page"),
      ),
      body:OrientationBuilder(
       builder: (context, orientation ){
         if(orientation == Orientation.portrait){
           return potrate();    // for ortrate screen

         }else {
               return landscape();  // for land scafe screen
         }
       },
      ),
    );
  }


  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => select.HomePage(  id: dbvalueproj.id , department: dbvalueproj.name, secondid: dbvalue.id, secondname: dbvalue.name),
        ));
  }

    // this tis the link of github   ===https://github.com/mayuriruparel/flutter_demo_apps/blob/master/flutter_sqlite_demo/lib/main.dart

  void _submitTarget(BuildContext context) {
    _fetchUsers();
    //if(_formKey.currentState.validate()){
    if (target == null) {
      for (int i = 0; i < listOfUsers.length; i++) {
        Target st = new Target (
            id: listOfUsers[i].id, name: listOfUsers[i].name);//

        dbmanager.insertStudent(st).then((id) =>

        //.clear(),
        // _courseController.clear(),

        //  print('Student Added to Db ${id} ${st.course}')
        print('target test ${st.id} ${st.name} ')
          // }
        );
      }
    }
    else {
//      for (int i = 0; i < listOfUsers.length; i++) {
        target.id = _currentUser.id;
        target.name = _currentUser.name;
//      }
      dbmanager.updateStudent(target).then((id) =>
      {
        setState(() {
//      for (int i = 0; i < listOfUsers.length; i++) {
        studlist[updateIndex].id = _currentUser.id;
        studlist[updateIndex].name = _currentUser.name;
//      }
        }),
        // _nameController.clear(),
        // _courseController.clear(),
        target = null
      });
    }
  }



  void _submitProject(BuildContext context) {
    _secondfetchUsers();
    //if(_formKey.currentState.validate()){
    if (target == null) {
      for (int i = 0; i < secoundlistOfUsers.length; i++) {
        ProjectTarget st = new ProjectTarget (
            id: secoundlistOfUsers[i].id, name: secoundlistOfUsers[i].name);//

        dbmanager.insertProject(st)
            .then((id) =>

        //.clear(),
        // _courseController.clear(),

        //  print('Student Added to Db ${id} ${st.course}')
        print('project test ${st.id} ${st.name} ')
          // }
        );
      }
    } else {
//      for (int i = 0; i < listOfUsers.length; i++) {
      target.id = _secondcurrentUser.id;
      target.name = _secondcurrentUser.name;
//      }
      dbmanager.updateStudent(target).then((id) =>
      {
        setState(() {
//      for (int i = 0; i < listOfUsers.length; i++) {
          projlist[updateIndex].id = _secondcurrentUser.id;
          projlist[updateIndex].name = _secondcurrentUser.name;
//      }
        }),
        // _nameController.clear(),
        // _courseController.clear(),
        target = null
      });
    }
    //    print('project test');
//    //if(_formKey.currentState.validate()){
//    if (project == null) {
//      for (int i = 0; i < secoundlistOfUsers.length; i++) {
//        Project pr = new Project (
//            idPro: secoundlistOfUsers[i].idPro, namePro: secoundlistOfUsers[i].namePro); //
//
//        projectmanager.insertProject(pr).then((id) =>
//
//        //.clear(),
//        // _courseController.clear(),
//
//        //  print('Student Added to Db ${id} ${st.course}')
//        print('project test ${pr.idPro} ${pr.namePro} ')
//           //}
//        );
//      }
//    } /* else {
//      for (int i = 0; i < secoundlistOfUsers.length; i++) {
//        project.idPro = secoundlistOfUsers[i].idPro;
//        project.namePro = secoundlistOfUsers[i].namePro;
//      }
//      dbmanager.updateProject(project).then((id) =>
//      {
//        setState(() {
//          for (int i = 0; i < secoundlistOfUsers.length; i++) {
//            // project[updateIndexPro].idPro = secoundlistOfUsers[i].idPro;
//            // project[updateIndexPro].namePro = secoundlistOfUsers[i].namePro;
//          }
//        }),
//        // _nameController.clear(),
//        // _courseController.clear(),
//        project = null
//      });
//    } */
  }

  Future<void> _sendData() async {
    print("send data started working");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        dbmanager.query().then((value) {
          setState(() {
            value.forEach((element) {
              QandAlist.add(QuestionOfftarget(id: element['id'],question: element['question'],type: element['type'],option_id: element['option_id']));

            });
          });
        }).catchError((error) {
          print("items error $error");
        });
        if(QandAlist.isNotEmpty){
        //  dio send data to server
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet Connection Avalible",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

 }

