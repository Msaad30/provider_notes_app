import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes_app/database/db_helper.dart';
import 'package:provider_notes_app/models/note_model.dart';
import 'package:provider_notes_app/provider/notes_provider.dart';
import 'package:provider_notes_app/screens/write_notes.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/ui_helper.dart';

class ShowNotes extends StatefulWidget {
  const ShowNotes({super.key});

  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {

  late DbHelper mydb;

  delete(noteid){
    context.read<NotesProvider>().deleteNote(noteid);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotesProvider>(
        builder: (_,data,__) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text("${index+1}"),
                title: Text(data.getAllNotes()[index].title.toString()),
                subtitle: Text(data.getAllNotes()[index].desc.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){
                      titleController.text = data.getAllNotes()[index].title;
                      descController.text = data.getAllNotes()[index].desc;
                      showModalBottomSheet(
                          context: context,
                          builder: (_){
                            return Container(
                                height: 700,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    UiHelper.customTextFeild(
                                          (){},
                                        hintText: "",
                                        suffIcon: Icons.text_fields_outlined,
                                      controller: titleController,
                                    ),
                                    UiHelper.customTextFeild(
                                      (){},
                                      controller: descController,
                                      hintText: "",
                                      suffIcon: Icons.description,
                                    ),
                                    ElevatedButton(
                                        onPressed: (){
                                          context.read<NotesProvider>().updateNote(
                                              NoteModel(
                                                  id: data.getAllNotes()[index].id,
                                                  title: titleController.text.toString(),
                                                  desc: descController.text.toString()
                                              )
                                          );
                                          context.read<NotesProvider>().getAllNotes();
                                          log("data updated");
                                          Navigator.pop(context);
                                        },
                                        child: Text("Update")
                                    )
                                  ],
                                )
                            );
                          }
                      );

                    }, icon: const Icon(Icons.edit),),
                    IconButton(
                      onPressed: (){
                        delete(data.getAllNotes()[index].id?.toInt());
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
            itemCount: data.getAllNotes().length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context)=> WriteNotes())
            );
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
