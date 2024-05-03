import 'package:provider_notes_app/database/db_helper.dart';
import 'package:provider_notes_app/provider/notes_provider.dart';

class NoteModel{
  int? id;
  String title;
  String desc;

  NoteModel({
    this.id,
    required this.title,
    required this.desc
  });

  Map<String, dynamic> toMap() {
    return {
      DbHelper.id: id,
      DbHelper.title: title,
      DbHelper.desc: desc,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic>MapData) {
    return NoteModel(
        id: MapData[DbHelper.id],
        title: MapData[DbHelper.title],
        desc: MapData[DbHelper.desc]
    );
  }

}