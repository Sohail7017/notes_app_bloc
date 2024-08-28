import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_bloc.dart';
import 'package:note_app_bloc/bloc/note_events.dart';
import 'package:note_app_bloc/bloc/note_state.dart';
import 'package:note_app_bloc/screens/edit_note.dart';



class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(NotesFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Notes',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.search,size: 30,color: Colors.white,),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.settings,size: 30,color: Colors.white,),
          )
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (_,state) {
          if(state is NotesLoadingState) {
            return Center(child:  CircularProgressIndicator());
          }else if(state is NotesErrorState) {
            return Center(child:  Text("${state.msgError}"));
          }else if(state is NotesLoadedState) {
            return state.noteList.isNotEmpty ?ListView.builder(
                itemCount: state.noteList.length,
                itemBuilder: (_,index){
                  return ListTile(
                    leading: Text('${index+1}',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                    title: Text(state.noteList[index].title, style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    subtitle: Text(state.noteList[index].desc, style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 60,
                      child: Row(children: [
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(isUpdate: true, updateNote: state.noteList[index],)));
                            },
                            child: Icon(Icons.edit,size: 30,color: Colors.deepPurple,)),
                        InkWell(
                            onTap: (){
                             context.read<NoteBloc>().add(NotesDeleteEvent(s_no: state.noteList[index].s_no!));
                              },
                            child: Icon(Icons.delete,size: 30,color: Colors.red,))
                      ],),
                    ),
                  );
                }): Center(
              child: Container(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note,size: 70,color: Colors.deepPurple.shade400,),
                  Text('No Notes yet!!',style: TextStyle(fontSize: 20,color: Colors.deepPurple.shade400,fontWeight: FontWeight.bold),),

                ],),),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35)
        ),
        tooltip: 'Add Notes',

        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote()));
        },
        child: Icon(Icons.add,size: 30,),
      ),


    );
  }

}