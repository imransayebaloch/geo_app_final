// import 'dart:html' as html;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_app_final/collect_lat_long.dart' as select;
import 'package:geo_app_final/collect_lat_long.dart';
//import 'package:geo_app_final/secoundDbManager.dart';
import 'package:geo_app_final/server_response.dart';
//import 'package:geo_app_final/your_location.dart' as location;
import 'package:sqflite/sqflite.dart';
//import '../your_location.dart';
//import 'server_response.dart';
import 'package:http/http.dart' as http;
//import 'function_of_ropDown.dart';
import 'dart:convert';
import '../DropDown Model/Dropdown_model.dart';
import '../DBmanager/dbmanager.dart';
import 'package:connectivity/connectivity.dart';
import '../DropDown Model/DropDown_Project_Model.dart';
import '../Login Form/Login_Form.dart';
//import 'transition_route_observer.dart';
import '../Login form/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login form/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Mytest/item_test.dart';
import '../Mytest/Mytest.dart';
import 'package:geo_app_final/DropDownClass/DropDowClass.dart';
import 'package:geo_app_final/menu_item.dart';
import 'package:hexcolor/hexcolor.dart';
// ignore: avoid_web_libraries_in_flutter

void main() => runApp(

    // LoginPage()
    // LoginScreen()
    DropDown());

class DropDown extends StatefulWidget {
  DropDown() : super();
  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return new MaterialApp(
      //   debugShowCheckedModeBanner: false,
      home: Location(),
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
  ProjectTarget ptarget;
//  Project project, dbProjectValue;
  List<Target> targetlist;
  List<ProjectTarget> projlist;
  int updateIndex, updateIndexPro;
  List<Users> listOfUsers;
  List<Users> secoundlistOfUsers;
  Target dbvalue;
  ProjectTarget dbvalueproj;
  SharedPreferences sharedPreferences;
//var offline  = new List();

  //Future<List<Target>> offlist ;
  Future<List<Target>> offlineList;
  //           offlist = dbmanager.getStudentList();
  // }

  @override
  void initState() {
    print('login screen is called');
    super.initState();
    // _senToLogincreen(context);
    checkLoginStatus();

    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // this.getJsonData();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
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

  final uri =
      'https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/qda%20project'; //by jawad https://raw.githubusercontent.com/iamjawad/sample_data/main/qda.json
  Users _currentUser;
  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Second URI  ================================
  final seconduri =
      'https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/qda%20target'; // by jawad  https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json
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

  Widget potrate() {
    return Container(
      child: Center(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5.0),

            //==========================================================================================
            // Container(
            //   height: 30,
            //   width: 250,
            //   decoration: BoxDecoration(
            //     color: HexColor('#FFFFFF'),
            //     //  color: Colors.white,
            //     border: Border.all(
            //       color: Colors.black,
            //     ),
            //     borderRadius: BorderRadius.circular(0.0),
            //   ),
            //

            Padding(
              padding: const EdgeInsets.only(right: 10, left: 80),
              child: FutureBuilder<List<ProjectTarget>>(
                  //This one for first dropdown
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
                          ? Text("" + dbvalueproj.name)
                          : Text(
                              "No project selected"), //Text('select Target'+_secondcurrentUser.name),
                    );
                  }),
            ),

            SizedBox(
              height: 10,
            ),

            // Divider(
            //       color: Colors.black,
            //     ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 150),
            //   child: Text('SELECT TARGET'),
            // ),

            // Container(
            //   height: 30,
            //   width: 250,
            //   decoration: BoxDecoration(
            //     color: HexColor('#E0E0E0'),
            //     //  color: Colors.white,
            //     border: Border.all(
            //       color: Colors.black,
            //     ),
            //     borderRadius: BorderRadius.circular(0.0),
            //   ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 80),
              child: FutureBuilder<List<Target>>(
                  //This one for first dropdown
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
                          ? Text("" + dbvalue.name)
                          : Text(
                              "No Target selected"), //Text('select Target'+_secondcurrentUser.name),
                    );
                  }),
            ),

            SizedBox(
              height: 60,
            ),

            Image.asset(
              'images/tagging2.png',
              width: 350.0,
              height: 180.0,
              fit: BoxFit.cover,
            ),

/*
           FutureBuilder<List<Users>>(
                future: _secondfetchUsers(),
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
                        : Text("No Project selected online"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }),

            FutureBuilder<List<Users>>(                     //This one for first dropdown
                future:_fetchUsers(),
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
                        _currentUser = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,

                    hint: _currentUser != null
                        ? Text("" +
                        _currentUser.name )
                        : Text("No Target selected online"),//Text('select Target'+_secondcurrentUser.name),

                  );
                }),
                        */

            //     Future<List<Drink>> fetchDrinks() async {
            // Database db = await instance.database;
            // var dbClient = await db;
            // var result = await dbClient.rawQuery("SELECT * FROM $table");
            // List<Map<String, dynamic>> r = result.toList().map((data) => Drink.fromJson(data));
            // return r;
            // }

            //
            // FutureBuilder<List>(
            //   future: dbmanager.getStudentList(),
            //   initialData: List(),
            //   builder: (context, snapshot) {
            //     return snapshot.hasData ?
            //     new ListView.builder(
            //       padding: const EdgeInsets.all(10.0),
            //       itemCount: snapshot.data.length,
            //       itemBuilder: (context, i) {
            //         return _buildRow(snapshot.data[i]);
            //       },
            //     )
            //         : Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // ),

            // if(_fetchUsers() == dbmanager.getStudentList() || _secondfetchUsers() == dbmanager.getProjectList() )
            //   Text('tru'),

            // for(int b = 0 ; b < 5 ; b ++ )
            //    if( listOfUsers[b] == secoundlistOfUsers[b] )
            //      Text('tru'),
            //   // }
            //  else
            //   {}

            //  Text('agan tru'),
            //    else{
            //       Text('fals')
            // }

            // FutureBuilder<List<Target>>(                     //This one for first dropdown
            //     future: dbmanager.getStudentList(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<List<Target>> snapshot) {
            //       if (!snapshot.hasData) return CircularProgressIndicator();
            //       return offlist =
            //       //   Column (
            //       //   children: [
            //       //     Text('this is my target list ${dbmanager.getStudentList()}')
            //       //   ],
            //       //
            //       // );
            //     }
            //       ),
            SizedBox(
              height: 50,
            ),

            // Divider(
            //     color: Colors.black
            // ),

            Padding(
              padding: const EdgeInsets.only(right: 10, top: 20),
              child: Text(
                'Tap on  Start to begin collecting coordinate or\n                 aginst selected project & target',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            /*       Expanded(
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

            // Container(
            //   margin: const EdgeInsets.only(top: 100.0),
            //   child: RaisedButton(
            //     color: Colors.blue,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //     onPressed: () {
            //       if(dbvalueproj == null || dbvalueproj == null  ){
            //         Fluttertoast.showToast(
            //             msg: 'Select both dropdown',
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.BOTTOM,
            //             // timeInSecForIos: 1,
            //             backgroundColor: Colors.blueGrey,
            //             textColor: Colors.white
            //         );
            //       }else {
            //         _sendDataToSecondScreen(context);
            //       }
            //     },
            //     child: Text("Start", style: TextStyle(color: Colors.white),),
            //   ),
            //
            // )    , //staert button

            // RaisedButton(
            //   color: Colors.blue,
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //   onPressed: () {
            //     _submitTarget(context);
            //     //  _sendDataTotestDropdown(context);
            //     _submitProject(context);
            //   },
            //   child: Text("DB Test", style: TextStyle(color: Colors.white),),
            // ),

            /* FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                onPressed: (){
                      _submitTarget(context);
                //  _sendDataTotestDropdown(context);
                  _submitProject(context);
                },
                child: Text(
                  "DB Test",
                )
            ),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //
                //
                //  width: 190.0,
                //              height: 190.0,
                // decoration: new BoxDecoration(
                //     shape: BoxShape.circle,
                //  image: new DecorationImage(
                // fit: BoxFit.fill,
                //    Image.asset(
                //          'images/tagging.png',
                //     width: 45.0,
                //     height: 45.0,
                //     fit: BoxFit.cover,
                //   )
                //        )

                // RaisedButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   onPressed: () {
                //     print("hello");
                //     int id=24;
                //     dbmanager.deleteStudent(id);
                //     dbmanager.deleteProject(id);
                //     setState(() {
                //       // studlist.removeAt(id);
                //     });
                //     print('db checked ');
                //   },
                //   child: Text("db delete", style: TextStyle(color: Colors.white),),
                // ),
                /* FlatButton(
           color: Colors.blue,
           textColor: Colors.white,
           splashColor: Colors.blueAccent,
           onPressed: (){
             print("hello");
             int id=24;
             dbmanager.deleteStudent(id);
             dbmanager.deleteProject(id);
             setState(() {
               // studlist.removeAt(id);
             });
             print('db checked ');
           },
           child: Text(
             "DB Detete",
           )
       ),*/
                // RaisedButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   onPressed: () {
                //     _submitTarget(context);
                //     _submitProject(context);
                //     CircularProgressIndicator();
                //     /*offlineList = dbmanager.getStudentList();
                //     if(listOfUsers == offlineList){
                //       print('true');
                //     }else{
                //       print('fals ${offlineList} for online ${listOfUsers}');
                //     }*/
                //     setState(() {
                //       // studlist.removeAt(id);
                //     });
                //     },
                //   child: Text("Sync", style: TextStyle(color: Colors.white),),
                // ),

                /*  FlatButton(
           color: Colors.blue,
           textColor: Colors.white,
           splashColor: Colors.blueAccent,
           onPressed: (){
          //   offlineList();
          //   _secondfetchUsers();
          // for (int b = 0; b<5 ; b++ )
          //                   print(listOfUsers[b]);
           CircularProgressIndicator();
             offlineList = dbmanager.getStudentList();
        //     print('offline data $offlineList');
         // if (listOfUsers.any((element) => offlineList.contains(element))){
           if(listOfUsers == offlineList){
            print('true');
          }else{
               print('fals ${offlineList} for online ${listOfUsers}');
             }
          //   print('tru');
          //
          // }
          // else{
          //   print('false');
          // }
            //  offlineList == dbmanager.getStudentList();
            // targetlistooo == dbmanager.getStudentList();
           // print('my data ${dbmanager.getStudentList()} online data ${listOfUsers[1]}');


             // print(' my db list ${
             //     () async {
             // final Future<List<Target>> futureList = dbmanager.getStudentList();
             // final
             //     list  = await futureList;
             //  print(list);
             // }
             //    // dbmanager.getStudentList().toString()
             // }');
             // for(int b = 0; b < 5 ; b++ ) {
             //   if ( listOfUsers[b] ==  dbmanager.getStudentList()) {
             //     print('tru');
             //   } else {
             //     print('fals');
             //   }
             // }
             // dbmanager.deleteStudent(id);
             // dbmanager.deleteProject(id);
             setState(() {
               // studlist.removeAt(id);
             });
           },
           child: Text(
             "Sync",
           )
       ),*/
              ],
            ),

            /*     FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                       // builder: (context) => SwipeDeleteDemo(), // LoginScreen(),

                          builder: (context) => SignInDemo(),

                      ));
                },
                child: Text(
                  "My Item",
                )
            ),*/

            //================================= testing button=====
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        print("hello");
                        int id = 24;
                        dbmanager.deleteStudent(id);
                        dbmanager.deleteProject(id);
                        setState(() {
                          // studlist.removeAt(id);
                        });
                        print('db checked ');
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 10),
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        _submitTarget(context);
                        _submitProject(context);
                        CircularProgressIndicator();
                        /*offlineList = dbmanager.getStudentList();
                           if(listOfUsers == offlineList){
                             print('true');
                           }else{
                             print('fals ${offlineList} for online ${listOfUsers}');
                           }*/
                        setState(() {
                          // studlist.removeAt(id);
                        });
                      },
                      child: Text(
                        "Sync",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // FloatingActionButton(
                  //   backgroundColor: Colors.blue, //const Color(0xff03dac6),
                  //   foregroundColor: Colors.white,
                  //   mini: true,
                  //   onPressed: () {
                  //
                  //     if(dbvalueproj == null || dbvalueproj == null  ){
                  //       Fluttertoast.showToast(
                  //           msg: 'Select both dropdown',
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.BOTTOM,
                  //           // timeInSecForIos: 1,
                  //           backgroundColor: Colors.blueGrey,
                  //           textColor: Colors.white
                  //       );
                  //     }else {
                  //       _sendDataToSecondScreen(context);
                  //     }
                  //
                  //   },
                  //   child: Icon(Icons.),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 15),
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if (dbvalueproj == null || dbvalueproj == null) {
                          Fluttertoast.showToast(
                              msg: 'Select both dropdown',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              // timeInSecForIos: 1,
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white);
                        } else {
                          _sendDataToSecondScreen(context);
                        }
                      },
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //=========================================
          ],
        ),
      ),
    );
  } //===============

  Widget landscape() {
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
        title: new Text("Geo Tagging"),
        actions: <Widget>[
          // FlatButton(
          //
          //   onPressed: () {
          //     sharedPreferences.clear();
          //     sharedPreferences.commit();
          //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
          //   },
          //   child: Text("Log Out", style: TextStyle(color: Colors.white)),
          // ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return potrate(); // for ortrate screen

          } else {
            return landscape(); // for land scafe screen
          }
        },
      ),
      drawer: Drawer(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                /*  width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                             // image: new Image.asset(
                             //
                             //        'images/imran.jpg',
                             //   width: 45.0,
                             //   height: 45.0,
                             //   fit: BoxFit.cover,
                             // )
                        )
                    ),*/
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: const Color(0xFF262AAA),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    ListTile(
                      title: Text(
                        "imran syed",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      // subtitle: Text(
                      //   "www..com",
                      //   style: TextStyle(
                      //     color: Color(0xFF1BB5FD),
                      //     fontSize: 18,
                      //   ),
                      // ),

                      leading: CircleAvatar(
                        // radius: 70,
                        //  child:
                        //  Image.asset(
                        //    'images/imran.jpg',
                        //    width: 45.0,
                        //    height: 45.0,
                        //    fit: BoxFit.cover,
                        //  ),
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                        radius: 50,
                      ),
                    ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.home,
                      title: "Home",
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => DropDown()),
                            (Route<dynamic> route) => false);
                        // onIconPressed();
                        // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.person,
                      title: "My Account",
                      onTap: () {
                        // onIconPressed();
                        // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                      },
                    ),
                    /* MenuItem(
                      icon: Icons.shopping_basket,
                      title: "My Orders",
                      onTap: () {
                        // onIconPressed();
                        // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                      },
                    ),*/
                    // MenuItem(
                    //   icon: Icons.card_giftcard,
                    //   title: "Wishlist",
                    // ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.settings,
                      title: "Settings",
                    ),
                    MenuItem(
                      icon: Icons.exit_to_app,
                      title: "Logout",
                      onTap: () {
                        sharedPreferences.clear();
                        sharedPreferences.commit();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
            /*   Align(
              alignment: Alignment(0, -0.9),
              child: GestureDetector(
                onTap: () {
                  onIconPressed();
                },
                child: ClipPath(
                  clipper: CustomMenuClipper(),
                  child: Container(
                    width: 35,
                    height: 110,
                    color: Color(0xFF262AAA),
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: Color(0xFF1BB5FD),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),

        //@override
        //Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
        /* child: Padding(
       padding: const EdgeInsets.fromLTRB(10,200,60,20),
       child: Text("Login", style: TextStyle(fontSize: 20,color: Colors.red),),
     ),*/
        // switch (event) {
        // case NavigationEvents.HomePageClickedEvent:
        // yield HomePage();
        // break;
        // case NavigationEvents.MyAccountClickedEvent:
        // yield MyAccountsPage();
        // break;
        // case NavigationEvents.MyOrdersClickedEvent:
        // yield MyOrdersPage();
        // break;
        // }
        //}
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => select.HomePage(
              id: dbvalueproj.id,
              department: dbvalueproj.name,
              secondid: dbvalue.id,
              secondname: dbvalue.name),
        ));
  }

  void _sendDataTotestDropdown(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnhancedDropDown(), // LoginScreen(),
        ));
  }

  void _senToLogincreen(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ServerResponse(), // LoginScreen(),
        ));
  }

  // this tis the link of github   ===https://github.com/mayuriruparel/flutter_demo_apps/blob/master/flutter_sqlite_demo/lib/main.dart

  void _submitTarget(BuildContext context) {
    _fetchUsers();
    //if(_formKey.currentState.validate()){
    if (target == null) {
      for (int i = 0; i < listOfUsers.length; i++) {
        Target st =
            new Target(id: listOfUsers[i].id, name: listOfUsers[i].name); //

        dbmanager.insertStudent(st).then((id) =>

                //.clear(),
                // _courseController.clear(),

                //  print('Student Added to Db ${id} ${st.course}')
                print('target test ${st.id} ${st.name} ')
            // }
            );
      }
    } else {
//      for (int i = 0; i < listOfUsers.length; i++) {
      target.id = _currentUser.id;
      target.name = _currentUser.name;
//      }
      dbmanager.updateStudent(target).then((id) => {
            setState(() {
//      for (int i = 0; i < listOfUsers.length; i++) {
              targetlist[updateIndex].id = _currentUser.id;
              targetlist[updateIndex].name = _currentUser.name;
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
        ProjectTarget st = new ProjectTarget(
            id: secoundlistOfUsers[i].id, name: secoundlistOfUsers[i].name); //

        dbmanager.insertProject(st).then((id) =>

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
      dbmanager.updateStudent(target).then((id) => {
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

  Widget _buildRow(Target target) {
    return new ListTile(
      title: new Text(target.name),
    );
  }
}
