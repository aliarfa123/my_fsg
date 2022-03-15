import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  String? title = '';
  String? _title;
  @override
  Widget build(BuildContext context) {
    TextEditingController a = TextEditingController();
    TextEditingController b = TextEditingController();
    List notes = [
      'Note 1',
      'Note 2',
      'Note 3',
      'Note 4',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Notes List'),
      ),
      body: Stack(
        children: [
          // ListView.builder(
          //   itemCount: notes.length,
          //   itemBuilder: ((context, index) {
          // return Container(
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     notes[index],
          //     style: TextStyle(fontSize: 20, color: Colors.black),
          //   ),
          // );
          //   }),
          // ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  notes[0],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  notes[1],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  notes[2],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              if (title != null)
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title!,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Notes',
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.cancel,
                                          color: primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextFormField(
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString('title', value);
                                    },
                                    controller: a,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Title',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    controller: b,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Description',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      //Return String
                                      title = prefs.getString('title');
                                      print(title);
                                      setState(() {
                                        _title = title;
                                        print(_title);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primary,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Add',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: 60,
                  child: Image(
                    image: AssetImage('assets/images/add_icon.png'),
                    color: primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// _read() async {
//   try {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/my_file.txt');
//     String text = await file.readAsString();
//     print(text);
//   } catch (e) {
//     print("Couldn't read file");
//   }
// }

// _save() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/my_file.txt');
//   final text = 'Hello World!';
//   await file.writeAsString(text);
//   print('saved');
// }
