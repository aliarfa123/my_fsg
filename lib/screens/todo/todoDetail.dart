import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class ToDoDetail extends StatefulWidget {
  var address;
  var images;
  var title;
  var desc;
  var date;
  ToDoDetail(
      {Key? key, this.title, this.desc, this.date, this.address, this.images})
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('To Do Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'Date: ' + widget.date.toString().split(' ').first,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Wrap(
              children: [
                Text(
                  widget.title + ' - ' + widget.address,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                Text(
                  'Description: ' + widget.desc,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Images:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  newList.length,
                  (index) => Container(
                    height: 150,
                    width: 150,
                    child: Image(
                      image: NetworkImage(
                        newList[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Expanded(
            //   child: StreamBuilder(
            //     stream: FirebaseDatabase.instance
            //         .ref('Images')
            //         .child(
            //           widget.title.toString(),
            //         )
            //         .orderByKey()
            //         .onValue
            //         .asBroadcastStream(),
            //     builder:
            //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //       final tilesList = <Widget>[];
            //       if (snapshot.hasData) {
            //         final address = Map<String, dynamic>.from(
            //             (snapshot.data!).snapshot.value);
            //         address.forEach((key, value) {
            //           final nextAdress = Map<String, dynamic>.from(value);
            //           final adressTile = Padding(
            //             padding: EdgeInsets.all(9),
            //             child: GestureDetector(
            //                 onTap: () {},
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       border: Border.all(color: Colors.grey),
            //                       borderRadius: BorderRadius.circular(10),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.grey.withOpacity(0.5),
            //                           blurRadius: 4,
            //                           offset: Offset(0, 4),
            //                         )
            //                       ]),
            //                   height: MediaQuery.of(context).size.height * 0.11,
            //                   child: Center(
            //                     child: ListTile(
            //                       title: Text(
            //                         nextAdress.keys.toString(),
            //                       ),
            //                       // title: Image(
            //                       //   image: NetworkImage(
            //                       //     nextAdress.keys.toString(),
            //                       //   ),
            //                       // ),
            //                     ),
            //                   ),
            //                 )),
            //           );
            //           tilesList.add(adressTile);
            //         });
            //       }
            //       return ListView(
            //         children: tilesList,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
