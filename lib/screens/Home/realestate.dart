import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/proprtyList/pdf.dart';
import 'package:my_fsg/theme/colors.dart';
import '../proprtyList/propertydetial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      readData();
      readImage();
      readName();
      readContact();
      readEmail();
      readTel();
    });
  }

  String? searchKey;
  Stream? streamQuery;
  List<String> newList = [];
  var data1;
  Map<dynamic, dynamic>? p1;
  readData() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          newList.add(values['Address']);
        });
      });
      setState(() {
        newDataList = newList;
      });
      //print(newDataList);
    });
  }

  readImage() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          imageList.add(values['image_link']);
        });
      });
    });
  }

  readName() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          nameList.add(values['Name']);
        });
      });
      // setState(() {
      //   newDataList = newList;
      // });
      //print(nameList);
    });
  }

  readEmail() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          emailList.add(values['Email']);
        });
      });
      // setState(() {
      //   newDataList = newList;
      // });
      //print(emailList);
    });
  }

  readContact() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          contactList.add(values['Contact']);
        });
      });
    });
  }

  readTel() {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('Addresses');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        data1 = data;
        p1 = data1;
      });
      p1!.forEach((key, values) {
        setState(() {
          telList.add(values['Tel']);
        });
      });
      // setState(() {
      //   newDataList = newList;
      // });
      //print(telList);
    });
  }

  List<String> newDataList = [];
  List<String> nameList = [];
  List<String> contactList = [];
  List<String> emailList = [];
  List<String> telList = [];
  List<String> imageList = [];
  onItemChanged(value) {
    setState(() {
      newDataList = newList
          .where(
            (string) => string.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  Map<String, dynamic>? addressSearch;
  List addresses = [];
  var address;

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
      body: SingleChildScrollView(
        child: Column(
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
                onChanged: onItemChanged,
                controller: search,
                // onChanged: (value) {
                //   setState(() {
                //     newDataList = newList
                //         .where((string) => string
                //             .toLowerCase()
                //             .contains(value.toLowerCase()))
                //         .toList();
                //   });
                // },
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
            Column(
              children: List.generate(
                newDataList.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetail(
                            contact: contactList[index].toString(),
                            email: emailList[index].toString(),
                            name: nameList[index].toString(),
                            tel: telList[index].toString(),
                            image: imageList[index].toString(),
                            address: newList[index].toString(),
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
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.2,
                            image: NetworkImage(
                              imageList[index],
                            ),
                          ),
                          title: Text(
                            newDataList[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: StreamBuilder(
            //     stream: FirebaseDatabase.instance
            //         .ref('Addresses')
            //         .orderByKey()
            //         .onValue,
            //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //       final tilesList = <Widget>[];
            //       if (snapshot.hasData) {
            //         final address = Map<String, dynamic>.from(
            //             (snapshot.data!).snapshot.value);
            //         address.forEach((key, value) {
            //           final nextAdress = Map<String, dynamic>.from(value);
            //           final adressTile = Padding(
            //             padding: EdgeInsets.all(9),
            //             child: Column(
            //               children: [
            //                 GestureDetector(
            //                   onTap: () {
            //                     // readData();

            //                     // print(address);
            //                     // setState(() {
            //                     //   addressSearch = nextAdress;
            //                     //   print(addressSearch);
            //                     // });
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => PropertyDetail(
            //                           contact: nextAdress['Contact'].toString(),
            //                           email: nextAdress['Email'].toString(),
            //                           name: nextAdress['Name'].toString(),
            //                           tel: nextAdress['Tel'].toString(),
            //                           image: nextAdress['image_link'].toString(),
            //                           address: nextAdress['Address'].toString(),
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         border: Border.all(color: Colors.grey),
            //                         borderRadius: BorderRadius.circular(10),
            //                         boxShadow: [
            //                           BoxShadow(
            //                             color: Colors.grey.withOpacity(0.5),
            //                             blurRadius: 4,
            //                             offset: Offset(0, 4),
            //                           )
            //                         ]),
            //                     height: size.height * 0.11,
            //                     child: Center(
            //                       child: ListTile(
            //                         leading: Image(
            //                           image: NetworkImage(
            //                             nextAdress['image_link'].toString(),
            //                           ),
            //                         ),
            //                         title: Text(
            //                           nextAdress['Address'].toString(),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //           tilesList.add(adressTile);
            //         });
            //       }
            //       return Column(
            //         children: [
            //           Expanded(
            //             child: ListView(
            //               children: tilesList,
            //             ),
            //           ),
            //         ],
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
