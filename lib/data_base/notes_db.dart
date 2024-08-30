import 'dart:io';

import 'package:note_app_bloc/data_base/user_model.dart';
import 'package:note_app_bloc/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class NotesDb{

  NotesDb._();

  static final NotesDb getInstance = NotesDb._();
  static final String tableName = 'noteTable';
  static final String columnSno =  's_no';
  static final String columnTitle = 'title';
  static final String columnDesc = 'desc';

  static final String USER_TABLE = 'user';
  static final String COLUMN_USER_ID = 'user_id';
  static final String COLUMN_USER_NAME = 'user_name';
  static final String COLUMN_USER_EMAIL = 'user_email';
  static final String COLUMN_USER_PASS = 'user_pass';



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
      db.rawQuery("create table $tableName ( $columnSno integer primary key autoincrement , $COLUMN_USER_ID integer ,$columnTitle text, $columnDesc text)");
      db.execute('create table $USER_TABLE ( $COLUMN_USER_ID integer primary key , $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text unique , $COLUMN_USER_PASS)');
    });

  }

  /// Add Note

Future<bool> addNote(NoteModel newNote) async{
    var db = await getDb();
    var uID = await getId();
    newNote.user_id = uID;

    int rowsEffected = await db.insert(tableName, newNote.toMap());
    return rowsEffected>0;
}

/// Fetch All Notes
Future<List<NoteModel>> fetchAllNotes() async{
    var db = await getDb();

    List<NoteModel> mNote = [];
    var uID = await getId();
     var allNotes = await db.query(tableName, where: "$COLUMN_USER_ID = ? " ,whereArgs:  ['$uID'] );
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

 /// queries for user add
/// user sign up
  Future<bool> addUser(UserModel newUser) async{
    var db = await getDb();
    bool haveAccount = await isEmailAlreadyExits(newUser.email);
    bool createdAccount = false;
    if(!haveAccount){
      var rowsEffected = await db.insert(USER_TABLE, newUser.toMap());
      createdAccount = rowsEffected>0;
    }
    return createdAccount;

  }
  /// Check Already have account
  Future<bool> isEmailAlreadyExits(String email) async{
    var db = await getDb();

    var mData = await db.query(USER_TABLE , where:  "$COLUMN_USER_EMAIL = ?", whereArgs: [email]);

  return mData.isNotEmpty;
  }

  /// Login user
Future<bool> userLogin(String email, String password) async{
    var db = await getDb();
    
    var mData = await db.query(USER_TABLE , where: "$COLUMN_USER_EMAIL = ? AND $COLUMN_USER_PASS = ?" ,whereArgs: [email,password]);

    if(mData.isNotEmpty){
      setId(UserModel.fromMap(mData[0]).u_id);
    }

    return mData.isNotEmpty;
}
    Future<int> getId() async{
    var prefers = await SharedPreferences.getInstance();
    return prefers.getInt('USER_ID')!;

    }

    void setId(int userId) async{

    var prefers = await SharedPreferences.getInstance();
    prefers.setInt('USER_ID', userId);

    }

}