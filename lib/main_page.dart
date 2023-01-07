import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_hive/boxes/boxes.dart';
import 'package:notes_hive/model/notes_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HiveDatabase"),
      ),
      body:ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_){
          var data =  box.values.toList().cast<NotesModel>();
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context,index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data[index].title.toString()),
                        Text(data[index].description.toString())
                      ],
                    ),
                  ),
                );
              }
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> _showMyDialog()async{
    return showDialog(
        context: context,
        builder: (context){
        return AlertDialog(
          title:Text("add notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,color: Colors.black54
                        )
                      ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptioncontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              final data = NotesModel(title:titlecontroller.text,
              description: descriptioncontroller.text);
              final box = Boxes.getData();
              box.add(data);
              //data.save();
              titlecontroller.clear();
              descriptioncontroller.clear();

              Navigator.pop(context);
            },
                child: Text('Add')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Cancel'))
          ],
        );
        }
        );
  }
  @override
  void dispose(){
    super.dispose();
    Hive.close();
  }
}
