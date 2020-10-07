import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_app_final/collect_deparment.dart' as select;
import 'package:geo_app_final/collect_deparment.dart';
import 'package:geo_app_final/your_location.dart' as location;
import 'your_location.dart';
import 'tasget_dropdown.dart';
import 'server_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



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



class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Computer Science'),
      Company(2, 'Fine Arts'),
      Company(3, 'English'),
      Company(4, 'Balochi'),
      Company(5, 'Zoloogy'),
    ];
  }
}
//===============================

class Company2 {
  int id;
  String name;

  Company2(this.id, this.name);

  static List<Company2> getCompanies2() {
    return <Company2>[
      Company2(1, 'gwadar'),
      Company2(2, 'jiwani'),
      Company2(3, 'pishukan'),
      Company2(4, 'Balochi'),
      Company2(5, 'Quetta'),
    ];
  }
}

//=================================

class DropDownState extends State<DropDown> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(


      debugShowCheckedModeBanner: false,

      home:  Location(),
    );
  }
}


class Location extends StatefulWidget {



  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
final String url= "https://raw.githubusercontent.com/iamjawad/sample_data/main/qda.json";
List data;

List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

   List<Company2> _companies2 = Company2.getCompanies2();
  List<DropdownMenuItem<Company2>> _dropdownMenuItems2;
  Company2 _selectedCompany2;
 // String imran = "d";





  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;

    _dropdownMenuItems2 = buildDropdownMenuItems2(_companies2);
    _selectedCompany2 = _dropdownMenuItems2[0].value;

    super.initState();
    this.getJsonData();

  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"Application/Json"}

    );
    print('Response check' + response.body);
    setState(() {

      var  convertDataToJson = json.decode(response.body);
      data = convertDataToJson['id'];

    });
    return "success";
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
//==========================================

  List<DropdownMenuItem<Company2>> buildDropdownMenuItems2(List companies2) {
    List<DropdownMenuItem<Company2>> items = List();
    for (Company2 company2 in companies2) {
      items.add(
        DropdownMenuItem(
          value: company2,
          child: Text(company2.name),
        ),
      );
    }
    return items;
  }

  //===========================================

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;


    });
  }
  //=====================================

  onChangeDropdownItem2(Company2 selectedCompany2) {
    setState(() {
      _selectedCompany2 = selectedCompany2;

    });
  }
  //====================================



  @override
  Widget build(BuildContext context) {

    //String value;
    print("test");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("First page"),
      ),
      body:  Container(
      child: Center(
          child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //this is first dropdown
              Padding(
                padding: const EdgeInsets.only(right: 150,top: 20),
                child: Text("SELECT PROJECT"),
              ),


              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
           //Text('Selected: ${_selectedCompany.name}' ),

              Divider(
                color: Colors.black,
              ),

               Padding(
                 padding: const EdgeInsets.only(right: 150),
                 child: Text('SELECT TARGET'),
               ),
              DropdownButton(
                value: _selectedCompany2,
                items: _dropdownMenuItems2,
                onChanged: onChangeDropdownItem2,
              ),
            //  Text('Selected: ${_selectedCompany2.name}'),
              Divider(
                  color: Colors.black
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 60.0),
              //   child: Divider(
              //       color: Colors.black
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(right: 10, top:96),

                child: Text(
                  'Tap on  Start to begin collecting coordinate or\n                 aginst selected project & target',
                  style: TextStyle(fontWeight: FontWeight.bold),

                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: Divider(
              //       color: Colors.black
              //   ),
              // ),

              //this is start button container
              Container(


              margin: const EdgeInsets.only(top: 100.0),
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: (){
                      print(_selectedCompany.name);
                       _sendDataToSecondScreen(context);
                     // _sendDataToServerScreen(context);
                     // Navigator.push(context, MaterialPageRoute(builder: (_)=> select.MyApp()));
                     // Navigator.push(context, MaterialPageRoute(builder: (context) => select.HomePage(text:_selectedCompany.name),));
                    },
                    child: Text(
                      "Start",
                    )
                ),
              )


            ],
          ),
        ),
      ),
    );
  }


  void _sendDataToSecondScreen(BuildContext context) {
    // String textToSend = textFieldController.text;
   // String textToSend = imran;
    Navigator.push(
        context,
        MaterialPageRoute(
         // builder: (context) => HomePage(text: textToSend,),
          builder: (context) => select.HomePage(  id: _selectedCompany.id , department: _selectedCompany.name, ),
        ));
  }

 /* void _sendDataToServerScreen(BuildContext context) {
    // String textToSend = textFieldController.text;
    // String textToSend = imran;
    Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => HomePage(text: textToSend,),
        //  builder: (context) => ServerResponse(  id: _selectedCompany.id , department: _selectedCompany.name, ),
        ));
 } */

}
