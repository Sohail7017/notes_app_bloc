import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_bloc.dart';
import 'package:note_app_bloc/bloc/note_events.dart';
import 'package:note_app_bloc/data_base/notes_db.dart';
import 'package:note_app_bloc/model/note_model.dart';



class EditNote extends StatefulWidget{
  bool isUpdate;
  NoteModel? updateNote;
  EditNote({this.isUpdate = false , this.updateNote});
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  NotesDb? mainDb;
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(widget.isUpdate){
      titleController.text = widget.updateNote!.title;
      descController.text = widget.updateNote!.desc;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true ,
        backgroundColor: Colors.deepPurple,
        title: Text(widget.isUpdate ? 'Update Note' :'Add Note',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Text('Title',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Enter your title....',
                    hintStyle: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Description',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                maxLines: 4,
                controller: descController,
                decoration: InputDecoration(
                    hintText: 'Enter your description.....',
                    hintStyle: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 110,
                    child: ElevatedButton(onPressed: (){
                      addNoteInDB();
                      titleController.clear();
                      descController.clear();
                      Navigator.pop(context);
                    }, child: Text(widget.isUpdate ? 'Update' : 'Add',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)


              ],
            )
          ],
        ),
      ),
    );
  }
  void addNoteInDB(){
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    widget.isUpdate ?
    context.read<NoteBloc>().add(NotesUpdateEvent(updateNote: NoteModel(title: mTitle, desc: mDesc, user_id: 0), s_no: widget.updateNote!.s_no!))
        : context.read<NoteBloc>().add(NotesAddEvent(newNotes: NoteModel(title: mTitle, desc: mDesc,user_id: 0)));
  }

}