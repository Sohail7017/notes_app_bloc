import 'package:note_app_bloc/data_base/notes_db.dart';

class NoteModel {
  int? s_no;
  String title;
  String desc;

  NoteModel({this.s_no, required this.title,required this.desc});

  /// from map

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
        s_no: map[NotesDb.columnSno],
        title: map[NotesDb.columnTitle],
        desc: map[NotesDb.columnDesc]);
  }

  /// To map

Map<String,dynamic> toMap(){
    return {
      NotesDb.columnTitle: title,
      NotesDb.columnDesc: desc
    };
}

}