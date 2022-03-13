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
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  notes[index],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomRight,
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
        ],
      ),
    );
  }
}
