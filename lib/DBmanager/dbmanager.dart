import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStudentManager {
  Database _database ;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE projects(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE Location(assetid INTEGER , lat TEXT, lng TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE QuestionAwnsers(assetid INTEGER , question TEXT, awnser TEXT, type TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE Questions(id INTEGER PRIMARY KEY, option_id TEXT , options TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE QuestionsOflline(id INTEGER PRIMARY KEY, question TEXT, type TEXT,option_id text)",   //,course TEXT
        );
      } );
    }
  }

  /* Future openDbProject() async {
    if (_projectDatabase == null) {
      _projectDatabase = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 2, onCreate: (Database db2, int version) async {
        await db2.execute(
          "CREATE TABLE project(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT

        );

      } );
    }
  }*/
  //this is for target
  Future<int> insertStudent(Target target) async {
    await openDb();
    return await _database.insert('student', target.toMap());
  }
  Future<int> insertlocation(LatlngTarget target) async {
    await openDb();
    return await _database.insert('Location', target.toMap());
  }
  Future<int> insertProject(ProjectTarget target) async {
    await openDb();
    return await _database.insert('projects', target.toMap());

  }
  Future<int> insertAwnser(awnserTarget target) async {
    await openDb();
    return await _database.insert('QuestionAwnsers', target.toMap());

  }
  Future<int> insertQuestions(QuestionTarget target) async {
    await openDb();
    return await _database.insert('Questions', target.toMap());

  }
  Future<int> insertQuestionsOffline(QuestionOfftarget target) async {
    await openDb();
    return await _database.insert('QuestionsOflline', target.toMap());

  }

  // this is for project



// for target
  Future<List<Target>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Target(
          id: maps[i]['id'], name: maps[i]['name']);
    });
  }
  Future<List<QuestionOfftarget>> getQuestionOff() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('QuestionsOflline');
    return List.generate(maps.length, (i) {
      return QuestionOfftarget(
          id: maps[i]['id'], question: maps[i]['question'], type: maps[i]['type'], option_id: maps[i]['option_id']);
    });
  }
  Future<List<ProjectTarget>> getProjectList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('projects');
    List<Map> list= await _database.rawQuery('SELECT * FROM Projects');
    print("here get project $list");
    return List.generate(maps.length, (i) {
      return ProjectTarget(
          id: maps[i]['id'], name: maps[i]['name']);
    });
  }
  Future<List<LatlngTarget>> getlocationlist() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('Location');
    List<Map> list= await _database.rawQuery('SELECT * FROM Location');
    print("here get Location $list");
    return List.generate(maps.length, (i) {
      return LatlngTarget(
          assetid: maps[i]['assetid'], lat: maps[i]['lat'], lng: maps[i]['lng']);
    });
  }
  Future<List<awnserTarget>>getAwnsers() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('QuestionAwnsers');
    List<Map> list= await _database.rawQuery('SELECT * FROM QuestionAwnsers');
    print("here get Location $list");
    return List.generate(maps.length, (i) {
      return awnserTarget(
          assetid: maps[i]['assetid'], question: maps[i]['question'], awnser: maps[i]['awnser'], type: maps[i]['type']);
    });
  }
  Future<List<QuestionTarget>>getQuestions() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('Questions');
    List<Map> list= await _database.rawQuery('SELECT * FROM Questions');
    print("here get Location $list");
    return List.generate(maps.length, (i) {
      return QuestionTarget(
          option_id: maps[i]['option_id'], options: maps[i]['options']);
    });
  }

  /* Future<List<Project>> getProjectList() async {
    await openDbProject();
    final List<Map<String, dynamic>> maps = await _projectDatabase.query('project');
    return List.generate(maps.length, (i) {
      return Project(
          idPro: maps[i]['idPro'], namePro: maps[i]['namePro']);
    });
  } */

  Future<int> updateStudent(Target target) async {
    await openDb();
    return await _database.update('student', target.toMap(),
        where: "id = ?", whereArgs: [target.id]);
  }
  Future<int> updateAwnsers(awnserTarget target) async {
    await openDb();
    return await _database.update('QuestionAwnsers', target.toMap(),
        where: "question = ?", whereArgs: [target.question]);
  }
/*
  Future<int> updateProject(Project project) async {
    await openDbProject();
    return await _projectDatabase.update('project', project.toMap(),
        where: "idPro = ?", whereArgs: [project.idPro]);
  } */

  Future<void> deleteStudent(int id) async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );
    print("object");
    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    await _database
        .rawDelete('DELETE FROM student');

    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
  Future<List<Map<String,dynamic>>> query() async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );

    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    var res  =
    await _database
        .rawQuery('SELECT * FROM QuestionsOflline');
    return res;
    // return list;

    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
  Future<void> queryQQQ() async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );

    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    List<Map> res  =
    await _database
        .rawQuery('SELECT * FROM QuestionAwnsers');
    print("question check123 $res");
    // return list;

    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
  Future<void> queryQQ() async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );

    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    List<Map> res  =
    await _database
        .rawQuery('SELECT * FROM QuestionsOflline');
    print("questionoff check123 $res");
    // return list;

    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
  Future<void> queryoption() async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );

    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    List<Map> res  =
    await _database
        .rawQuery('SELECT * FROM Questions');
    print("questionoption check1234 $res");
    // return res;

    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
  Future<List<Map<String,dynamic>>> Questions1() async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );
    var res  =
    await _database
        .rawQuery('SELECT * FROM Questions');
    return res;

    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);


    // List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
    //  print('new test $list');


  }
// Future<void> getQuestions() async {
//   await openDb();
//   // await _database.delete(
//   //     'student',
//   //     where: "id = ?", whereArgs: [id]
//   // );
//  await _database.rawQuery('SELECT * FROM Test');
//   //print('new test $_database');
// //  print('new test $list');
//
//
// }
/*
  Future<void> deleteProject(int id) async {
    await openDbProject();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );
    print("object");
    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    await _projectDatabase
        .rawDelete('DELETE FROM project');
    List<Map> list = await _projectDatabase.rawQuery('SELECT * FROM project');
    //print('new test $_database');
    print('new test $list');


  } */


}

class Target {
  int id;
  String name;
  // String course;
  Target({@required this.name,  this.id});
  Map<String, dynamic> toMap() {
    return {'id': id,'name': name};
  }

}
class ProjectTarget {
  int id;
  String name;
  // String course;
  ProjectTarget({@required this.name,  this.id});
  Map<String, dynamic> toMap() {
    return {'id': id,'name': name};
  }


}

class LatlngTarget {
  int assetid;
  double lat;
  double lng;
  // String course;
  LatlngTarget({@required this.assetid, this.lat, this.lng});
  Map<String, dynamic> toMap() {
    return {'assetid': assetid,'lat': lat,"lng":lng };
  }

}
class awnserTarget {
  int assetid;
  String question;
  String awnser;
  String type;
  // String course;
  awnserTarget({@required this.assetid, this.question,this.awnser,this.type});
  Map<String, dynamic> toMap() {
    return {'assetid': assetid,'question': question,'awnser':awnser,'type':type};
  }

// class Project {
//   int idPro;
//   String namePro;
//   // String course;
//   Project({@required this.namePro, this.idPro});
//   Map<String, dynamic> toMap() {
//     return {'idPro': idPro,'namePro': namePro};
//   }
//
}
class QuestionTarget {
  int id;
  String option_id;
  String options;
  // String course;
  QuestionTarget({@required this.id,this.option_id, this.options});
  Map<String, dynamic> toMap() {
    return {'id':id,'option_id': option_id,'options': options};
  }

}
class QuestionOfftarget {
  int id;
  String question;
  String type;
  String option_id;
  QuestionOfftarget({@required this.id, this.question,this.type,this.option_id});
  Map<String, dynamic> toMap() {
    return {'id': id,'question': question,'type': type,'option_id':option_id};
  }

}












/*

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStudentManager {
  Database _database ;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE projects(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE Location(assetid INTEGER , lat TEXT, lng TEXT)",   //,course TEXT
        );
        await db.execute(
          "CREATE TABLE QuestionAwnsers(assetid INTEGER , question TEXT, awnser TEXT)",   //,course TEXT
        );
      } );
    }
  }

 /* Future openDbProject() async {
    if (_projectDatabase == null) {
      _projectDatabase = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 2, onCreate: (Database db2, int version) async {
        await db2.execute(
          "CREATE TABLE project(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT

        );

      } );
    }
  }*/
  //this is for target
  Future<int> insertStudent(Target target) async {
    await openDb();
    return await _database.insert('student', target.toMap());
  }
  Future<int> insertlocation(LatlngTarget target) async {
    await openDb();
    return await _database.insert('Location', target.toMap());
  }
  Future<int> insertProject(ProjectTarget target) async {
    await openDb();
    return await _database.insert('projects', target.toMap());

  }
  Future<int> insertAwnser(awnserTarget target) async {
    await openDb();
    return await _database.insert('QuestionAwnsers', target.toMap());

  }

  // this is for project



// for target
  Future<List<Target>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Target(
          id: maps[i]['id'], name: maps[i]['name']);
    });
  }
  Future<List<ProjectTarget>> getProjectList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('projects');
    List<Map> list= await _database.rawQuery('SELECT * FROM Projects');
    print("here get project $list");
    return List.generate(maps.length, (i) {
      return ProjectTarget(
          id: maps[i]['id'], name: maps[i]['name']);
    });
  }
  Future<List<LatlngTarget>> getlocationlist() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('Location');
    List<Map> list= await _database.rawQuery('SELECT * FROM Location');
    print("here get Location $list");
    return List.generate(maps.length, (i) {
      return LatlngTarget(
          assetid: maps[i]['assetid'], lat: maps[i]['lat'], lng: maps[i]['lng']);
    });
  }
  Future<List<awnserTarget>>getAwnsers() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('QuestionAwnsers');
    List<Map> list= await _database.rawQuery('SELECT * FROM QuestionAwnsers');
    print("here get Location $list");
    return List.generate(maps.length, (i) {
      return awnserTarget(
          assetid: maps[i]['assetid'], question: maps[i]['question'], awnser: maps[i]['awnser']);
    });
  }

 /* Future<List<Project>> getProjectList() async {
    await openDbProject();
    final List<Map<String, dynamic>> maps = await _projectDatabase.query('project');
    return List.generate(maps.length, (i) {
      return Project(
          idPro: maps[i]['idPro'], namePro: maps[i]['namePro']);
    });
  } */

  Future<int> updateStudent(Target target) async {
    await openDb();
    return await _database.update('student', target.toMap(),
        where: "id = ?", whereArgs: [target.id]);
  }
/*
  Future<int> updateProject(Project project) async {
    await openDbProject();
    return await _projectDatabase.update('project', project.toMap(),
        where: "idPro = ?", whereArgs: [project.idPro]);
  } */

  Future<void> deleteStudent(int id) async {
    await openDb();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );
    print("object");
    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    await _database
        .rawDelete('DELETE FROM student');
     List<Map> list = await _database.rawQuery('SELECT * FROM student');
    //print('new test $_database');
  //  print('new test $list');


  }
/*
  Future<void> deleteProject(int id) async {
    await openDbProject();
    // await _database.delete(
    //     'student',
    //     where: "id = ?", whereArgs: [id]
    // );
    print("object");
    // await _database
    //     .rawDelete('DELETE FROM student WHERE id = ?', [id]);
    await _projectDatabase
        .rawDelete('DELETE FROM project');
    List<Map> list = await _projectDatabase.rawQuery('SELECT * FROM project');
    //print('new test $_database');
    print('new test $list');


  } */


}

class Target {
  int id;
  String name;
 // String course;
  Target({@required this.name,  this.id});
  Map<String, dynamic> toMap() {
    return {'id': id,'name': name};
  }

}
class ProjectTarget {
  int id;
  String name;
 // String course;
  ProjectTarget({@required this.name,  this.id});
  Map<String, dynamic> toMap() {
    return {'id': id,'name': name};
  }


}

class LatlngTarget {
  int assetid;
  double lat;
  double lng;
 // String course;
  LatlngTarget({@required this.assetid, this.lat, this.lng});
  Map<String, dynamic> toMap() {
    return {'assetid': assetid,'lat': lat,"lng":lng };
  }

}
class awnserTarget {
  int assetid;
  String question;
  String awnser;
  // String course;
  awnserTarget({@required this.assetid, this.question,this.awnser});
  Map<String, dynamic> toMap() {
    return {'assetid': assetid,'question': question,'awnser':awnser};
  }

// class Project {
//   int idPro;
//   String namePro;
//   // String course;
//   Project({@required this.namePro, this.idPro});
//   Map<String, dynamic> toMap() {
//     return {'idPro': idPro,'namePro': namePro};
//   }
//
 }      */