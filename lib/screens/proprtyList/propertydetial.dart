import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/bottomNavBar.dart';
import 'package:my_fsg/screens/proprtyList/noteslist.dart';
import 'package:my_fsg/screens/proprtyList/pdf.dart';
import 'package:my_fsg/screens/proprtyList/todolist.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class PropertyDetail extends StatefulWidget {
  var image;
  var address;
  PropertyDetail({
    Key? key,
    required this.image,
    required this.address,
  }) : super(key: key);

  @override
  State<PropertyDetail> createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RootApp(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Property Detail'),
        backgroundColor: primary,
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
                      image: AssetImage(widget.image), fit: BoxFit.fill),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: size.width * 0.45,
                child: Wrap(
                  children: [
                    Text(widget.address),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToDoList(),
                ),
              );
            },
            child: Container(
              height: size.height * 0.08,
              child: Image(
                image: AssetImage(
                  'assets/images/todolist.png',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesList(),
                ),
              );
            },
            child: Container(
              height: size.height * 0.08,
              child: Image(
                image: AssetImage(
                  'assets/images/notes_list.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
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
                  'Name:       ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact:    ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email:        ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneratePDF(
                    address2: widget.address,
                    image2: widget.image,
                  ),
                ),
              );
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
