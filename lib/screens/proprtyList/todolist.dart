import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/proprtyList/addToDo.dart';
import 'package:my_fsg/screens/proprtyList/propertydetial.dart';
import 'package:my_fsg/screens/todo/Completed.dart';
import 'package:my_fsg/screens/todo/inProgress.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class ToDoList extends StatefulWidget {
  var name;
  var dateTime;
  var title;
  ToDoList({
    Key? key,
    this.title,
    this.name,
    this.dateTime,
  }) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valueFourth = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text('Tasks To Do'),
          bottom: TabBar(indicatorColor: primary, labelColor: primary, tabs: [
            Tab(
              child: Text('In Progress',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            Tab(
              child: Text(
                'Completed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            InProgress(
              name: widget.name,
              title: widget.title,
            ),
            Completed(
              name: widget.name,
              title: widget.title,
            )
          ],
        ),
      ),
    );
  }
}
