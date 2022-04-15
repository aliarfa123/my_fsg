import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class ToDoDetail extends StatefulWidget {
  var address;
  var images;
  var title;
  var desc;
  var date;
  var name;
  ToDoDetail(
      {Key? key,
      this.title,
      this.desc,
      this.date,
      this.address,
      this.images,
      this.name})
      : super(key: key);

  @override
  State<ToDoDetail> createState() => _ToDoDetailState();
}

class _ToDoDetailState extends State<ToDoDetail> {
  List<String> newList = [];
  List<String> newDataList = [];
  var data1;
  Map<dynamic, dynamic>? p1;
  // readData() {
  //   DatabaseReference databaseref =
  //       FirebaseDatabase.instance.ref('Images/${widget.address}');
  //   databaseref.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     print(data);

  //     setState(() {
  //       p1?.forEach(
  //         (key, value) {
  //           newList.add(value);
  //         },
  //       );
  //       print(p1);
  //       print('arfa');
  //     });
  //   });
  // }
  readData() {
    DatabaseReference databaseref =
        FirebaseDatabase.instance.ref('Images/${widget.address.toString()}');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          newList.add(values);
        });
      });
      setState(() {
        newDataList = newList;
      });
      // print(newList);
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('To Do Detail'),
          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       text: 'Ducuments',
          //     ),
          //     Tab(
          //       text: 'Details',
          //     ),
          //   ],
          // ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Date: ' + widget.date.toString().split(' ').first,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Time: ' +
                          widget.date
                              .toString()
                              .split(' ')
                              .last
                              .split('.')
                              .first,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Divider(),
                // SizedBox(
                //   height: 20,
                // ),
                Wrap(
                  children: [
                    Text(
                      widget.name + ' - ' + widget.address,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Divider(),

                Row(
                  children: [
                    Text(
                      'Images:',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),

                if (newList.isNotEmpty)
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        newList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  newList[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    ),
                  ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Report',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: primary),
                        ),
                        labelText: 'Report text here',
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusColor: primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
