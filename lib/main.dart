import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_hive/main_page.dart';
import 'package:notes_hive/model/notes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);
   //await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  runApp(const Notes());
}

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Homescreen(),
    );
  }
}
