import 'package:note_app_bloc/data_base/notes_db.dart';

class NoteModel {
  int? s_no;
  int user_id;
  String title;
  String desc;

  NoteModel({this.s_no, required this.user_id, required this.title,required this.desc});

  /// from map

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(

        s_no: map[NotesDb.columnSno],
        user_id: map[NotesDb.COLUMN_USER_ID],
        title: map[NotesDb.columnTitle],
        desc: map[NotesDb.columnDesc]);
  }

  /// To map

Map<String,dynamic> toMap(){
    return {
      NotesDb.COLUMN_USER_ID : user_id,
      NotesDb.columnTitle: title,
      NotesDb.columnDesc: desc
    };
}

}