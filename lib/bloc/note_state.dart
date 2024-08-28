import '../model/note_model.dart';

abstract class NoteState{}

class NotesInitialState extends NoteState{}

class NotesLoadingState extends NoteState{}

class NotesLoadedState extends NoteState{
  List<NoteModel> noteList;
   NotesLoadedState({required this.noteList});
}

class NotesErrorState extends NoteState{
  String msgError;
  NotesErrorState({required this.msgError});
}