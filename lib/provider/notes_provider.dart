import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider_notes_app/database/db_helper.dart';
import 'package:provider_notes_app/models/note_model.dart';

class NotesProvider extends ChangeNotifier{

  List<NoteModel>notesArray = [];

  void addData({required String title, required String desc}){
    if(title == "" && desc == "") {
      log("Please enter data");
    } else {
      DbHelper().insert(
          NoteModel(
              title: title,
              desc: desc
          )
      );
      log("data added");
      notifyListeners();
    }
  }

  List<NoteModel> getAllNotes(){
    showNotes();
    return notesArray;
  }

  showNotes() async {
    notesArray = await DbHelper().fetch();
    notifyListeners();
  }

  deleteNote(int noteId) async{
    var check = await DbHelper().delete(noteId);
    if(check){
      notesArray = await DbHelper().fetch();
      notifyListeners();
    }
  }

  // this is my update provider
  updateNote(NoteModel noteModel) async {
    DbHelper().updateData(
        noteModel
      );
   }

}