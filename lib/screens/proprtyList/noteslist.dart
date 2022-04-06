import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';
import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';

class NotesList extends StatefulWidget {
  var name;
  NotesList({Key? key, required this.name}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  DatabaseReference db = FirebaseDatabase.instance.ref();
  var data1;
  setData(String title, String desc) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('notes/' + title);

    await ref.set({
      "description": desc,
    });
  }

  readData() async {
    DatabaseReference databaseref =
        FirebaseDatabase.instance.ref('notes/$title/');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        data1 = data;
      });
      return data1;
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  String? title = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController titleText = TextEditingController();
    TextEditingController desc = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Notes List'),
      ),
      body: Stack(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('Notes')
                  .child(
                    widget.name.toString(),
                  )
                  .orderByKey()
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                final tilesList = <Widget>[];
                if (snapshot.hasData) {
                  final address = Map<String, dynamic>.from(
                      (snapshot.data!).snapshot.value);
                  address.forEach((key, value) {
                    final nextAdress = Map<String, dynamic>.from(value);
                    final adressTile = Padding(
                      padding: EdgeInsets.all(9),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                )
                              ]),
                          height: size.height * 0.11,
                          child: Center(
                            child: ListTile(
                              title: Text(
                                nextAdress['Title'].toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    tilesList.add(adressTile);
                  });
                }
                return ListView(
                  children: tilesList,
                );
              },
            ),
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
                                    //   onChanged: (value) async {
                                    //     SharedPreferences prefs =
                                    //         await SharedPreferences.getInstance();
                                    //     prefs.setString('title', value);
                                    //   },
                                    controller: titleText,
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
                                    controller: desc,
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
                                    onTap: () {
                                      String pushKey = db.push().key.toString();
                                      db
                                          .child('Notes')
                                          .child(widget.name)
                                          .child(pushKey)
                                          .child('Title')
                                          .set(titleText.text);
                                      db
                                          .child('Notes')
                                          .child(widget.name)
                                          .child(pushKey)
                                          .child('Desc')
                                          .set(desc.text);
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
