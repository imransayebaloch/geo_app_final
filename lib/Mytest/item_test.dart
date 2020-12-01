import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();

  final String title = "Refresh/Swipe Delete Demo";

  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {

  Position _currentPosition;
 // List<Position> listOfCoordinates = new List();
  //
  List<String> companies; //= new List();
  GlobalKey<RefreshIndicatorState> refreshKey;
  Random r;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    r = Random();
    companies = List();
    addCompanies();

  }

   addCompanies() {
    //companies.add();
    //  companies.add("kaleel");
    //  companies.add("imran");
    //  companies.add("imran");
    //  companies.add("Naseeb");
    //  companies.add("Naveed");
    //  companies.add("Doctor Atif");

   }

  addRandomCompany() {
    int nextCount = r.nextInt(100);
    setState(() {
      companies.add("Company $nextCount");
    });
  }

  removeCompany(index) {
    setState(() {
      companies.removeAt(index);
    });
  }

  undoDelete(index, company) {
    setState(() {
      companies.insert(index, company);
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    addRandomCompany();
    return null;
  }

  showSnackBar(context, company, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$company deleted'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          undoDelete(index, company);
        },
      ),
    ));
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget list() {
    return ListView.builder(

      padding: EdgeInsets.only(top: 40),
      itemCount: companies.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );

  }

  Widget row(context, index) {
    return Dismissible(
      key: Key(companies[index]), // UniqueKey().toString()
      onDismissed: (direction) {
        var company = companies[index];
        showSnackBar(context, company, index);
        removeCompany(index);
      },
      background: refreshBg(),
      child: Card(
        child: ListTile(
          title: Text(companies[index]),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
                  _getCurrentLocation();
            },
            child: Text("I am location", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body:
      RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: list(),
      ),




     //   Container(  child: Row(
     //    mainAxisAlignment: MainAxisAlignment.center,
     //    children: [
     //      // Text('wow working')
     //
     //
     //
     //      FlatButton(
     //           color: Colors.blue,
     //           textColor: Colors.white,
     //           splashColor: Colors.blueAccent,
     //           onPressed: (){
     //
     //           },
     //           child: Text(
     //             "lat long test",
     //           )
     //       )
     //   ],
     // ),
     // )
    );


  }


  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
//if(listOfCoordinates!=null){}
      companies.add(position.toString());

      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }



}