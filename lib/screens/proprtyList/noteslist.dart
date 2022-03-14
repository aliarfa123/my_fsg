import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
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
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: ((context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  notes[index],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => SingleChildScrollView(
                          child: AlertDialog(
                            backgroundColor: primary,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add Notes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextFormField(
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: primary)),
                                  labelText: 'Title',
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusColor: primary,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: primary)),
                                  labelText: 'Description',
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusColor: primary,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primary,
                                ),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
