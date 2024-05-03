import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes_app/provider/notes_provider.dart';
import 'package:provider_notes_app/screens/note_list.dart';
import 'package:provider_notes_app/screens/write_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: ShowNotes(),
      ),
    );
  }
}
