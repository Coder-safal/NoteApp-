import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noteapp_sec/classes/helper_class.dart';
import 'package:noteapp_sec/pages/edit_page.dart';
import 'package:noteapp_sec/pages/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> noteList = [];

  late SharedPreferences shPref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((value) {
      shPref = value;
      getData();
      // setState(() {});
    });
  }

  void saveData() async {
    shPref.setString("myList", jsonEncode(noteList));
  }

  void getData() async {
    String? savedList = shPref.getString("myList");

    if (savedList != null && savedList.isNotEmpty) {
      var DecodedData = jsonDecode(savedList);

      for (var item in DecodedData) {
        noteList.add(item as Map<String, dynamic>);
      }
    }
    print("Initial noteList: ${noteList}");
    setState(() {});
  }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteApp"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noteList[index]['title'].toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 41, 74),
                              fontWeight: FontWeight.w400,
                              fontSize: 21,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Text(noteList[index]['body'].toString()),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(
                                titleText: noteList[index]['title'],
                                bodyText: noteList[index]['body'],
                                onChanged: (v) {
                                  print("Edit text: ${v}");
                                  noteList[index]['title'] = v.first;
                                  noteList[index]['body'] = v.last;
                                  setState(() {});
                                  saveData();
                                },
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          noteList.remove(noteList[index]);
                          setState(() {});
                          saveData();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: noteList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddNote(onChanged: (v) {
                // print("title and body is: ${v.first}");
                noteList.add({
                  "title": v.first,
                  "body": v.last,
                  "id": Helper.IdGenerator()
                });
                setState(() {});
                saveData();
              });
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
