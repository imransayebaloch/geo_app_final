import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProjectManager {
  Database _projectDatabase;


  Future openDbProject() async {
    if (_projectDatabase == null) {
      _projectDatabase = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE project(id INTEGER PRIMARY KEY autoincrement, name TEXT)",   //,course TEXT

        );

      } );
    }
  }


  // this is for project

  Future<int> insertProject(Project project) async {
    await openDbProject();
    return await _projectDatabase.insert('project', project.toMap());
  }

// for target


  Future<List<Project>> getProjectList() async {
    await openDbProject();
    final List<Map<String, dynamic>> maps = await _projectDatabase.query('project');
    return List.generate(maps.length, (i) {
      return Project(
          idPro: maps[i]['idPro'], namePro: maps[i]['namePro']);
    });
  }



  Future<int> updateProject(Project project) async {
    await openDbProject();
    return await _projectDatabase.update('project', project.toMap(),
        where: "idPro = ?", whereArgs: [project.idPro]);
  }



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


  }


}




class Project {
  int idPro;
  String namePro;
  // String course;
  Project({@required this.namePro, this.idPro});
  Map<String, dynamic> toMap() {
    return {'idPro': idPro,'namePro': namePro};
  }

}