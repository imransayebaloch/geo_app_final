import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_app_final/collect_deparment.dart' as select;
import 'package:geo_app_final/collect_deparment.dart';
import 'package:geo_app_final/your_location.dart' as location;
import 'your_location.dart';
//import 'server_response.dart';
import 'package:http/http.dart' as http;
import 'function_of_ropDown.dart';
import 'dart:convert';
import 'Users_data.dart';

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

class _LocationState extends State<Location> {
  final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  Users _currentUser;
  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfUsers = items.map<Users>((json) {
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
      List<Users> listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;


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

            FutureBuilder<List<Users>>(
                future: _secondfetchUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Users>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator(); //valueColor: AlwaysStoppedAnimation<Color> (Colors.green),
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
                    hint:  _currentUser != null
                        ? Text("" +
                        _currentUser.name )
                        : Text("No Project selected"),//Text('Select Project'),

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
                }),

            // SizedBox(height: 20.0),
            // _secondcurrentUser != null
            //     ? Text("Name: " +
            //     _secondcurrentUser.name )
            //     : Text("No Target selected"),

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
                    print('second user ${_secondcurrentUser.name}');
                    _sendDataToSecondScreen(context);
                  },
                  child: Text(
                    "Start",
                  )
              ),
            )     //staert button
          ],
        ),
      ),
    );
  }    //===============

  Widget landscape(){
   /// its for landscape screen
  }

  @override
  void initState() {
    super.initState();
   // this.getJsonData();

  }

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
          builder: (context) => select.HomePage(  id: _currentUser.id , department: _currentUser.name, secondid: _secondcurrentUser.id, secondname: _secondcurrentUser.name),
        ));
  }
}
