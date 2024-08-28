import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_events.dart';
import 'package:note_app_bloc/bloc/note_state.dart';
import 'package:note_app_bloc/data_base/notes_db.dart';

class NoteBloc extends Bloc<NoteEvents, NoteState>{
  NotesDb db;
  NoteBloc({required this.db}) : super(NotesInitialState()){

    /// Add
    on<NotesAddEvent>((event, emit) async{
      emit(NotesLoadingState());
      bool check = await db.addNote(event.newNotes);
      if(check){
        var notes = await db.fetchAllNotes();
        emit(NotesLoadedState(noteList: notes));
      }else{
        emit(NotesErrorState(msgError: 'Notes add unsuccessful!!'));
      }
    });

    /// fetch
    on<NotesFetchEvent>((event, emit) async{
      emit(NotesLoadingState());
      var notes = await db.fetchAllNotes();
      emit(NotesLoadedState(noteList: notes));
    });

    /// Update
    on<NotesUpdateEvent>((event, emit) async{
      emit(NotesLoadingState());
      bool check = await db.updateNote(updateNote: event.updateNote, s_no: event.s_no);

      if(check){
        var notes = await db.fetchAllNotes();
        emit(NotesLoadedState(noteList: notes));
      }else{
        emit(NotesErrorState(msgError: 'Notes Update Unsuccessful!!!'));
      }
    });

    /// Delete

    on<NotesDeleteEvent>((event, emit) async{
      emit(NotesLoadingState());
      bool check = await db.deleteNote(s_no: event.s_no);
      if(check){
        var notes = await db.fetchAllNotes();
        emit(NotesLoadedState(noteList: notes));
      }else{
        emit(NotesErrorState(msgError: 'Note delete Unsuccessful!!'));
      }
    });


  }
}