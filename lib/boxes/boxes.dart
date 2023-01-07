import 'package:hive/hive.dart';
import 'package:notes_hive/model/notes_model.dart';

class Boxes{

    static Box<NotesModel> getData()
    {
        //Hive.close();
    return Hive.box<NotesModel>('notes');
    }
}