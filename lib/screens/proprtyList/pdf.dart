import 'package:firebase_database/firebase_database.dart';
import 'package:my_fsg/screens/proprtyList/widgetpdf.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class GeneratePDF extends StatefulWidget {
  var image2;
  var address2;
  var name;
  var contact;
  var email;
  var tel;
  GeneratePDF({
    Key? key,
    this.image2,
    this.address2,
    this.name,
    this.contact,
    this.email,
    this.tel,
  }) : super(key: key);

  @override
  State<GeneratePDF> createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  List<String> notesList = [];
  List<String> toDoList = [];
  var data1;
  Map<dynamic, dynamic>? p1;

  Map<dynamic, dynamic>? p2;
  readNotes() {
    DatabaseReference databaseref =
        FirebaseDatabase.instance.ref('Notes').child(
              widget.address2.toString(),
            );
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          notesList.add(values['Title']);
        });
      });
      // setState(() {
      //   newDataList = newList;
      // });
      print(notesList);
    });
  }

  readToDo() {
    DatabaseReference databaseref =
        FirebaseDatabase.instance.ref('To Do').child(
              widget.address2.toString(),
            );
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p2 = data1;
      });
      p2!.forEach((key, values) {
        setState(() {
          toDoList.add(values['Title']);
        });
      });
      // setState(() {
      //   newDataList = newList;
      // });
      print(toDoList);
    });
  }

  @override
  void initState() {
    readNotes();
    readToDo();
  }

  // @override
  // void initState() {
  //   setState(() {
  //     var networkImg = widget.image2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Generate PDF'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  // color: primary,
                  image: DecorationImage(
                    image: NetworkImage(widget.image2),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: size.width * 0.45,
                child: Wrap(
                  children: [
                    Text(
                      widget.address2,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Details:',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name:  ' + widget.name.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact:   ' + widget.contact.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tel:   ' + widget.tel.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email:   ' + widget.email.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            onTap: () async {
              final pdfFile = await PdfApi.generateImage(
                widget.image2.toString(),
                widget.address2.toString(),
                widget.name.toString(),
                widget.contact.toString(),
                widget.tel.toString(),
                widget.email.toString(),
                notesList,
                toDoList,
              );
              PdfApi.openFile(pdfFile);
            },
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Generate PDF',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
