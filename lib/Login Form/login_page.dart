import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Email Model/email_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Main/main.dart';
//import 'dart:html';



// void main()
// => runApp(
//
//
//   // LoginPage()
//   // LoginScreen()
//     LoginPage()
// );

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  List<EmailAddress>  email_test;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),


          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.get("https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/Email%20Addres",);  //, body: data
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print('login test ${response.body}');
       // var  token = "jjjkhjkhjkhjkhkjh";
     //   if(jsonResponse['status'] == true){
          if(jsonResponse['email_address'] ==  email && jsonResponse['password'] == pass ){
          sharedPreferences.setString("token", jsonResponse['token'] );  //jsonResponse['token']
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DropDown()), (Route<dynamic> route) => false);

       } else {
          Fluttertoast.showToast(
              msg: 'Invalid email or password ',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
             // timeInSecForIos: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white
          );
          sharedPreferences.setString("token", null );  //jsonResponse['token']
        }

      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

 /* void email() async {
    var jsonResponse = null;
    var response = await http.get("https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/Email%20Addres");  //, body: data
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print('login test ${response.body}');
     //   sharedPreferences.setString("token", jsonResponse['token']);
   //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      }
    }
  } */

  final uri = 'https://raw.githubusercontent.com/imransayebaloch/QDA-question/main/Email%20Addres';
  EmailAddress _currentUser;
  Future<List<EmailAddress>> _emailTest() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      print('your email ${response.body}');
      email_test  = items.map<EmailAddress>((json) {
        return EmailAddress.fromJson(json);

      }).toList();

      return  email_test;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
          print('this is sign in dear imran');
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),

    );


  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Geo Tagging",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
  void callresponce(){

  }
}
