import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_bloc.dart';
import 'package:note_app_bloc/data_base/notes_db.dart';
import 'package:note_app_bloc/screens/home_page.dart';


void main(){
  runApp(
      BlocProvider(create: (context) => NoteBloc(db: NotesDb.getInstance),child:NoteApp()),
      );
}
class NoteApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}