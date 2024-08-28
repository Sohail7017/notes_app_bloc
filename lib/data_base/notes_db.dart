import 'dart:io';

import 'package:note_app_bloc/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesDb{

  NotesDb._();

  static final NotesDb getInstance = NotesDb._();
  static final String tableName = 'noteTable';
  static final String columnSno =  's_no';
  static final String columnTitle = 'title';
  static final String columnDesc = 'desc';


  Database? myDB;

  Future<Database> getDb() async{
    myDB ??= await openDB();
    return myDB!;

  }

  Future<Database> openDB() async{
    Directory appDirectory = await getApplicationDocumentsDirectory();

    String rootPath = appDirectory.path;

    String dbPath = join(rootPath, 'note.db');

    return await openDatabase(dbPath, version: 1 , onCreate: (db, version){
      db.rawQuery("create table $tableName ( $columnSno integer primary key autoincrement , $columnTitle text, $columnDesc text)");
    });

  }

  /// Add Note

Future<bool> addNote(NoteModel newNote) async{
    var db = await getDb();

    int rowsEffected = await db.insert(tableName, newNote.toMap());
    return rowsEffected>0;
}

/// Fetch All Notes
Future<List<NoteModel>> fetchAllNotes() async{
    var db = await getDb();

    List<NoteModel> mNote = [];
     var allNotes = await db.query(tableName);
     for(Map<String, dynamic> eachNote in allNotes){
       NoteModel eachModel = NoteModel.fromMap(eachNote);
       mNote.add(eachModel);
     }
     return mNote;
}

/// Update Note
 Future<bool> updateNote({required NoteModel updateNote , required int s_no}) async{
    var db = await getDb();
    int rowsEffected = await db.update(tableName, {
      columnTitle: updateNote.title,
      columnDesc: updateNote.desc,
    }, where: "$columnSno = $s_no");
    return rowsEffected>0;
 }

 Future<bool> deleteNote({required int s_no}) async{
    var db = await getDb();
    int rowsEffected = await db.delete(tableName, where: "$columnSno = ?" , whereArgs: ["$s_no"]);
    return rowsEffected>0;
 }

}