import 'package:note_app_bloc/model/note_model.dart';

abstract class NoteEvents {}

class NotesAddEvent extends NoteEvents{
  NoteModel newNotes;
  NotesAddEvent({required this.newNotes});
}
class NotesFetchEvent extends NoteEvents{}

class NotesUpdateEvent extends NoteEvents{
  NoteModel updateNote;
  int s_no;
  NotesUpdateEvent({required this.updateNote, required this.s_no});
}

class NotesDeleteEvent extends NoteEvents{
  int s_no;
  NotesDeleteEvent({required this.s_no});
}