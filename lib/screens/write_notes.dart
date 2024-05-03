import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes_app/database/db_helper.dart';
import 'package:provider_notes_app/models/note_model.dart';
import 'package:provider_notes_app/provider/notes_provider.dart';
import 'package:provider_notes_app/screens/note_list.dart';
import 'package:provider_notes_app/utils/ui_helper.dart';
import 'package:sqflite/sqflite.dart';

class WriteNotes extends StatefulWidget {
  const WriteNotes({super.key});

  @override
  State<WriteNotes> createState() => _WriteNotesState();
}

class _WriteNotesState extends State<WriteNotes> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customTextFeild(
                (){
                  titleController.text = "";
                },
                controller: titleController,
                hintText: "Title",
                suffIcon: Icons.title
            ),
            SizedBox(height: 10,),
            UiHelper.customTextFeild(
                (){
                  descController.text = "";
                },
                controller: descController,
                hintText: "description",
                suffIcon: Icons.description
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  context.read<NotesProvider>().addData(
                      title: titleController.text.toString(),
                      desc: descController.text.toString()
                  );
                  context.read<NotesProvider>().getAllNotes();
                },
                child: Text("Save Note")
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context)=> ShowNotes()));
        },
        child: Icon(Icons.receipt_outlined),
      ),
    );
  }
}
