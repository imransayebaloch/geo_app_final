import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_app_final/select_deparment.dart' as select;
import 'package:geo_app_final/select_deparment.dart';
import 'package:geo_app_final/your_location.dart' as location;
import 'your_location.dart';
import 'flutter_help.dart';
import 'tasget_dropdown.dart';


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

class DropDownState extends State<DropDown> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: Location(),
    );
  }
}


class Location extends StatefulWidget {



  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  //"Hello imran";


  //SecontDropDown(),

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
 // String imran = "d";





  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;

    super.initState();

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


  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }


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
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             // SecondDropDown(),


              //this is first dropdown
              Padding(
                padding: const EdgeInsets.only(right: 200,top: 20),
                child: Text("SELECT PROJECT"),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),

              SizedBox(
                height: 20.0,
              ),

              Text('Selected: ${_selectedCompany.name}'),

              //secound dropdown is started here
              Divider(
                  color: Colors.black
              ),

                //  OneTow(),
                 //  SecondDropDown(),




      /*        Padding(
                padding: const EdgeInsets.only(right: 200,top: 20),
                child: Text("SELECT PROJECT"),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),

              SizedBox(
                height: 20.0,
              ),

              Text('Selected: ${_selectedCompany.name}'),  */

              //this is start button container

              Container(


              margin: const EdgeInsets.only(top: 200.0),
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
          builder: (context) => HomePage(department: _selectedCompany.name,),
        ));
  }

}
