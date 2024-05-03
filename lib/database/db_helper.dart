import 'package:path_provider/path_provider.dart';
import 'package:provider_notes_app/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
 static final DbHelper db = DbHelper();
  Database? _database;
  static const database = "notes.db";
  static const table = "notes";
  static const id = "notes_id";
  static const title = "notes_title";
  static const desc = "notes_desc";

  final String createTable = '''
    CREATE TABLE $table (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT,
      $desc TEXT
    );
  ''';
  Future<Database> getDb() async {
    if(_database != null){
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = directory.path + database;
    return openDatabase(path, version: 1, onCreate: (db, version){
      db.execute(createTable);
    });
  }

  Future insert(NoteModel noteModel) async {
    var db = await getDb();
    db.insert(table, noteModel.toMap());
  }

  Future<List<NoteModel>>fetch() async {
    var db= await getDb();
    List<Map<String,dynamic>> notes = await db.query(table);
    List<NoteModel> listNotes = [];
    for(Map<String,dynamic>note in notes){
      NoteModel noteModel = NoteModel.fromMap(note);
      listNotes.add(noteModel);
    }
    return listNotes;
  }

   Future<bool> updateData(NoteModel noteModel) async {
     var db = await getDb();
     var count = await db.update(table, noteModel.toMap(), where: "$id = ${noteModel.id}" );
     return count > 0;
   }

  Future<bool>delete(int noteId) async {
    var db = await getDb();
    var count = await db.delete(table, where: "$id=?", whereArgs: [noteId.toString()]);
    return count > 0;
  }
}