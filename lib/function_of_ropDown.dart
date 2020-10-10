/* import 'package:flutter/cupertino.dart';

import 'Users_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void FirstDropDown(){
  final uri = 'https://raw.githubusercontent.com/iamjawad/sample_data/main/qda.json';
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

 body: FutureBuilder<List<Users>>(
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
              _currentUser = value;
            });
          },
          isExpanded: false,
          //value: _currentUser,
          hint: Text('Select User'),

        );
      }),




}*/