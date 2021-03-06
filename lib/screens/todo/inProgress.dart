import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/proprtyList/addToDo.dart';
import 'package:my_fsg/screens/todo/todoDetail.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class InProgress extends StatefulWidget {
  var name;
  var title;
  InProgress({Key? key, this.title, this.name}) : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref('To Do')
                    .child(
                      widget.title.toString(),
                    )
                    .orderByKey()
                    .onValue
                    .asBroadcastStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final tilesList = <Widget>[];
                  if (snapshot.hasData) {
                    final address = Map<String, dynamic>.from(
                        (snapshot.data!).snapshot.value);
                    address.forEach((key, value) {
                      final nextAdress = Map<String, dynamic>.from(value);
                      final adressTile = Padding(
                        padding: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToDoDetail(
                                  title: nextAdress['Title'],
                                  date: nextAdress['Date'],
                                  desc: nextAdress['Desc'],
                                  address: widget.title,
                                  name: widget.name,
                                ),
                              ),
                            );
                          },
                          child: nextAdress['Approved'] == 'false'
                              ? Container(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        nextAdress['Title'].toString(),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          var db = FirebaseDatabase.instance
                                              .ref("To Do")
                                              .child(widget.title)
                                              .child(key);
                                          db.update({'Approved': 'true'});
                                        },
                                        child: Icon(
                                          Icons.check_box_outline_blank,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
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

            // if (valuefirst == false)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Checkbox(
            //           onChanged: (value) {
            //             setState(() {
            //               this.valuefirst = value!;
            //             });
            //           },
            //           checkColor: Colors.white,
            //           activeColor: primary,
            //           value: this.valuefirst,
            //           // onChanged: (bool value) {
            //           //   setState(() {
            //           //     this.valuefirst = value;
            //           //   });
            //           // },
            //         ),
            //         Text(
            //           'Task 1',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
            // if (valuesec == false)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Checkbox(
            //           onChanged: (value) {
            //             setState(() {
            //               this.valuesec = value!;
            //             });
            //           },
            //           checkColor: Colors.white,
            //           activeColor: primary,
            //           value: this.valuesec,
            //           // onChanged: (bool value) {
            //           //   setState(() {
            //           //     this.valuefirst = value;
            //           //   });
            //           // },
            //         ),
            //         Text(
            //           'Task 2',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
            // if (valuethird == false)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Checkbox(
            //           onChanged: (value) {
            //             setState(() {
            //               this.valuethird = value!;
            //             });
            //           },
            //           checkColor: Colors.white,
            //           activeColor: primary,
            //           value: this.valuethird,
            //           // onChanged: (bool value) {
            //           //   setState(() {
            //           //     this.valuefirst = value;
            //           //   });
            //           // },
            //         ),
            //         Text(
            //           'Task 3',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddToDo(
                            address: widget.title,
                          )));
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
    );
  }
}
