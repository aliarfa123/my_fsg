import 'package:flutter/material.dart';
import 'package:my_fsg/screens/proprtyList/addToDo.dart';
import 'package:my_fsg/theme/colors.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valuefirst1 = true;
  bool valuesec2 = true;
  bool valuethird3 = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
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
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuefirst = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuefirst,
                            // onChanged: (bool value) {
                            //   setState(() {
                            //     this.valuefirst = value;
                            //   });
                            // },
                          ),
                          Text(
                            'Task 1',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuesec = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuesec,
                            // onChanged: (bool value) {
                            //   setState(() {
                            //     this.valuefirst = value;
                            //   });
                            // },
                          ),
                          Text(
                            'Task 2',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuethird = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuethird,
                            // onChanged: (bool value) {
                            //   setState(() {
                            //     this.valuefirst = value;
                            //   });
                            // },
                          ),
                          Text(
                            'Task 3',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddToDo()));
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
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuefirst1 = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuefirst1,
                          ),
                          Text(
                            'Task 1',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuesec2 = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuesec2,
                            //
                          ),
                          Text(
                            'Task 2',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                this.valuethird3 = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: primary,
                            value: this.valuethird3,
                          ),
                          Text(
                            'Task 3',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddToDo()));
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
          ],
        ),
      ),
    );
  }
}
