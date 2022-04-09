import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';
import '../proprtyList/propertydetial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchKey;
  Stream? streamQuery;
  var data1;
  // readData() {
  //   Query databaseref =
  //       FirebaseDatabase.instance.ref('Addresses').orderByChild('Email');

  //   databaseref.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     setState(() {
  //       data1 = data;
  //     });
  //     print(
  //       data,
  //     );
  //   });
  // }

  Map<String, dynamic>? addressSearch;
  List addresses = [];
  var address;

  // readData() async {
  //   Stream<DatabaseEvent> databaseref =
  //       FirebaseDatabase.instance.ref('Addresses').orderByKey().onValue;
  // databaseref.onValue.listen((DatabaseEvent event) {
  //   final data = event.snapshot.value;
  //   print(data);
  //   setState(() {
  //     address = data;
  //   });
  //   return address;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text(
            'Real Estate',
          ),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 20,
          //   ),
          //   width: size.width * 0.95,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: primary),
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(29),
          //   ),
          //   child: TextField(
          //     onChanged: ((value) {
          //       setState(() {
          //         searchKey = value;
          //         streamQuery = FirebaseDatabase.instance
          //             .ref('Addresses')
          //             .orderByKey()
          //             .onValue;
          //       });
          //     }),
          //     style: TextStyle(color: primary),
          //     cursorColor: primary,
          //     decoration: InputDecoration(
          //       icon: Icon(
          //         Icons.search,
          //         color: primary,
          //       ),
          //       hintText: 'Search',
          //       // hintStyle: TextStyle(
          //       //   color: primary,
          //       // ),
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),

          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('Addresses')
                  .orderByKey()
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                final tilesList = <Widget>[];
                if (snapshot.hasData) {
                  final address = Map<String, dynamic>.from(
                      (snapshot.data!).snapshot.value);
                  address.forEach((key, value) {
                    final nextAdress = Map<String, dynamic>.from(value);
                    final adressTile = Padding(
                      padding: EdgeInsets.all(9),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   addressSearch = nextAdress;
                              //   print(addressSearch);
                              // });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PropertyDetail(
                                    contact: nextAdress['Contact'].toString(),
                                    email: nextAdress['Email'].toString(),
                                    name: nextAdress['Name'].toString(),
                                    tel: nextAdress['Tel'].toString(),
                                    image: nextAdress['image_link'].toString(),
                                    address: nextAdress['Address'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
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
                              height: size.height * 0.11,
                              child: Center(
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                      nextAdress['image_link'].toString(),
                                    ),
                                  ),
                                  title: Text(
                                    nextAdress['Address'].toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    tilesList.add(adressTile);
                  });
                }
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: size.width * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        onChanged: ((value) {
                          setState(() {
                            searchKey = value;
                            streamQuery = FirebaseDatabase.instance
                                .ref('Addresses')
                                .orderByKey()
                                .onValue;
                          });
                        }),
                        style: TextStyle(color: primary),
                        cursorColor: primary,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: primary,
                          ),
                          hintText: 'Search',
                          // hintStyle: TextStyle(
                          //   color: primary,
                          // ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: tilesList,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
