import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:geo_app_final/select_deparment.dart' as select;
import 'package:geo_app_final/select_deparment.dart';
import 'package:geo_app_final/your_location.dart' as location;
import 'your_location.dart';




class SecondDropDown extends StatefulWidget {
  SecondDropDown() : super();
  final String title = "DropDown Demo";
  @override
  DropDownState createState() => DropDownState();
}



class SecondCompany {
  int id;
  String name;

  SecondCompany(this.id, this.name);

  static List<SecondCompany> getSecondCompanies() {
    return <SecondCompany>[
      SecondCompany(1, 'GENTS PARK'),
      SecondCompany(2, 'SPORTS GROUNDS'),
      SecondCompany(3, 'CHASHMA HOUSING SCHEME'),
      SecondCompany(4, 'ZARHOON HOUSING SCHEME'),
      SecondCompany(5, 'CHILTAN HOUSING SCHEME'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecoundLocation(),
    );
  }
}


class SecoundLocation extends StatefulWidget {



  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<SecoundLocation> {


  //
  List<SecondCompany> _companies11 = SecondCompany.getSecondCompanies();
  List<DropdownMenuItem<SecondCompany>> _dropdownMenuItems11;
  SecondCompany _selectedCompany11;

  @override
  void initState() {
    _dropdownMenuItems11 = buildDropdownMenuItems(_companies11);
    _selectedCompany11 = _dropdownMenuItems11[0].value;
    super.initState();

  }

  List<DropdownMenuItem<SecondCompany>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<SecondCompany>> items = List();
    for (SecondCompany company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }


  onChangeDropdownItem(SecondCompany selectedCompany) {
    setState(() {
      _selectedCompany11 = selectedCompany;
    });
  }


  @override
  Widget build(BuildContext context) {
    print("Second Test Activity");
    // return new Scaffold(
    //   appBar: new AppBar(
    //     title: new Text("First page"),
    //   ),
    //   body:  Container(
    //     child: Center(
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //this is first dropdown
              Padding(
                padding: const EdgeInsets.only(right: 200,top: 20),
                child: Text("SELECT TARGET"),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCompany11,
                items: _dropdownMenuItems11,
                onChanged: onChangeDropdownItem,
              ),

              SizedBox(
                height: 20.0,
              ),

              Text('Selected: ${_selectedCompany11.name}'),

              //secound dropdown is started here


              //this is start button container


            ],
      //     ),
      //   ),
      // ),
    );
  }
}
