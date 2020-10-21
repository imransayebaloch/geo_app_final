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
import 'collectionModel.dart';
import 'Users_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
   String selectedCoordinat,department, secondname;
   var collectcor = new List();
   int id,secondid;
   SubmitCoordinat({ Key key,this.id, this.department, this.selectedCoordinat,this.secondid,this.secondname,this.collectcor }):super(key: key );


  @override
  _HomePageState createState() => _HomePageState();  //value
}
class _HomePageState extends State<SubmitCoordinat> {


  final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  Users _currentUser;
  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfQuestion = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfQuestion;
    } else {
      throw Exception('Failed to load internet');
    }
  }


 /* final String quistionUri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/projects_data.json';
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(quistionUri),
      headers: {"Accept":"application/json"}
    );
    print(response.body);

    setState(() {
      var JSON;
      var convertDataToJson = JSON.decode(response.body);
      data = convertDataToJson['name'];
    });
    return "Success";
  }    */
 // Users _currentUser;
/*  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(quistionUri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfQuestion = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfQuestion;
    } else {
      throw Exception('Failed to load internet');
    }
  }         */




  //List<CollectionModel> items;
  List<CollectionModel> items =  List<CollectionModel>.generate(5, (i) => CollectionModel("Question $i"));
   List data = new List();
  //int  _controllers ;
  @override
  Widget build(BuildContext context) {
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

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(

               child:   CircleAvatar(
                    radius: 70,
                    backgroundColor: Color(0xffFDCF09),
                    child: CircleAvatar(
                      radius: 65,
                   child: Center(child: Text(widget.selectedCoordinat,style: TextStyle(height: 1, fontSize: 60))),
                    ),
                  )
              ),
            ),

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


            Expanded(
              child: FlatButton(
                child: Text('Question test'),
                color: Colors.green,
                onPressed: (){
                  print('W  $_fetchUsers()');
                },
              )



          /*    FutureBuilder<List<Users>>(
                  future: _fetchUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Users>> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return
                      ListView.builder(
                        // itemCount: data == null ? 0 :data.length ,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          //  _controllers.add(new TextEditingController());

                          return ListTile(
                            title: Text('wah'),
                            //  title: Text(data[index]['name']),
                            // subtitle: TextField(
                            //     //controller: data[index].fieldContorller,
                            //     decoration: const InputDecoration(
                            //       hintText: 'Enter your Awnser here',
                            //     )
                            // ),
                          );
                        },
                      );

                  }), */
            ),


            Divider(
                color: Colors.black
            ),
            // past here the quistionar


    Expanded(
      child:Container(
        height: 300,
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.green
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
       // padding: const EdgeInsets.only(right: 20.0,left:20,top: 10,bottom: 10),

        //================================================================

        //============================================================================================

        child: ListView.builder(
         // itemCount: data == null ? 0 :data.length ,
          itemCount: items.length,
          itemBuilder: (context, index) {
          //  _controllers.add(new TextEditingController());

            return ListTile(
              title: Text('${items[index].name}'),
            //  title: Text(data[index]['name']),
              subtitle: TextField(
                  controller: items[index].fieldContorller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Awnser here',
                  )
              ),
            );
          },
        ),
      ),),



            Padding(
              padding: const EdgeInsets.only(top: 1,left: 40),

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
                      //  print('Quistion test  ${items[ind]}');
                      //  print(listOfQuestion);
                        print(widget.department);
                        print(widget.selectedCoordinat);
                        print("hellow my list ${widget.collectcor}");
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


