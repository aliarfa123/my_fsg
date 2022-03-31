import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/bottomNavBar.dart';
import 'package:my_fsg/screens/proprtyList/ElectricMeter.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
                  width: size.width * 0.55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.25,
                  width: size.width * 0.42,
                  child: Wrap(
                    children: [
                      Text(
                        widget.address,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoList(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: size.height * 0.063,
                width: size.width * 0.6,
                child: Center(
                  child: Text(
                    'To Do List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
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
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: size.height * 0.063,
                width: size.width * 0.6,
                child: Center(
                  child: Text(
                    'Notes List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ElectricMeter(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: size.height * 0.063,
                width: size.width * 0.6,
                child: Center(
                  child: Text(
                    'Electricity Meter',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tel:            ________________',
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
                    'Send Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                    'Document Storage',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
