import 'package:note_app_bloc/data_base/notes_db.dart';

class UserModel{
  int u_id;
  String name;
  String email;
  String pass;

  UserModel({required this.u_id, required this.name, required this.email,required this.pass});


    factory UserModel.fromMap(Map<String,dynamic> map){
      return UserModel(
          u_id:  map[NotesDb.COLUMN_USER_ID],
          name: map[NotesDb.COLUMN_USER_NAME],
          email: map[NotesDb.COLUMN_USER_EMAIL],
          pass: map[NotesDb.COLUMN_USER_PASS]);
    }

    Map<String, dynamic> toMap(){
      return{
        NotesDb.COLUMN_USER_NAME : name,
        NotesDb.COLUMN_USER_EMAIL : email,
        NotesDb.COLUMN_USER_PASS : pass,
      };
    }

}