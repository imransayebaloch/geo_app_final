library enhanced_drop_down;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EnhancedDropDown extends StatefulWidget {
  final ValueChanged<String> valueReturned;

  EnhancedDropDown(
      {Key key,
        this.dropdownLabelTitle: "",
        this.dataSource,
        this.defaultOptionText: "",
        this.urlToFetchData: "",
        this.valueReturned})
      : super(key: key);

  final String defaultOptionText;
  final String dropdownLabelTitle;
  final String urlToFetchData;
  final List<String> dataSource;

  @override
  _EnhancedDropDownState createState() => _EnhancedDropDownState();
}

class _EnhancedDropDownState extends State<EnhancedDropDown> {
  List<DropdownMenuItem<String>> _data = [];
  String _selected;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _data = [];
    if (widget.urlToFetchData.isNotEmpty) {
      var response = await http.get(widget.urlToFetchData);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        List<DropdownMenuItem<String>> menuItems = [];
        jsonResponse.forEach((key, value) {
          menuItems.add(new DropdownMenuItem(
            child: new Text(value.toString()),
            value: value.toString(),
          ));
        });
        setState(() {
          _data = menuItems;
        });
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } else {
      for (int i = 0; i < widget.dataSource.length; i++) {
        _data.add(new DropdownMenuItem(
          child: new Text(widget.dataSource[i]),
          value: widget.dataSource[i],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return new Container();
    } else {
      return new Scaffold(
          body: new Column(
            children: <Widget>[
              new Text(widget.dropdownLabelTitle, textDirection: TextDirection.ltr),
              DropdownButton(
                  value: _selected,
                  items: _data,
                  hint: new Text(widget.defaultOptionText),
                  onChanged: (value) {
                    _selected = value;
                    widget.valueReturned(_selected);
                    setState(() {});
                  })
            ],
          ));
    }
  }
}

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// //import 'dr';
// import '../DropDown Model/DropDown_Project_Model.dart';
//
// class OfflineDropDown extends StatefulWidget {
//   //List<ProjectTarget> projlist;
//   @override
//   _OfflineDropDownState createState() => _OfflineDropDownState();
// }
//
// class _OfflineDropDownState extends State<OfflineDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container( child:
//
//        // List<ProjectTarget> projlist;
//
//     // classvoid Offline() { offlineDropDown {
//
//         FutureBuilder<List<ProjectTarget>>(                     //This one for first dropdown
//         future: dbmanager.getProjectList(),
//         builder: (BuildContext context,
//         AsyncSnapshot<List<ProjectTarget>> snapshot) {
//         if (!snapshot.hasData) return CircularProgressIndicator();
//         return DropdownButton<ProjectTarget>(
//         items: snapshot.data
//             .map((user) => DropdownMenuItem<ProjectTarget>(
//         child: Text(user.name),
//         value: user,
//         ))
//             .toList(),
//         onChanged: (ProjectTarget value) {
//         setState(() {
//         dbvalueproj = value;
//         });
//         },
//         isExpanded: false,
//         //value: _currentUser,
//
//         hint: dbvalueproj != null
//         ? Text("" +
//         dbvalueproj.name )
//             : Text("No project selected"),//Text('select Target'+_secondcurrentUser.name),
//
//         );
//         }),
//
//
//         );
//   }
// }
//
//
//
//   }
// }