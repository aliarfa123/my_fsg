import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

import '../proprtyList/propertydetial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // readData() async {
  //   Query databaseref = FirebaseDatabase.instance
  //       .ref('Addresses')
  //       .orderByKey()
  //       .orderByChild('Adress');
  //   databaseref.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     print(data);
  //     setState(() {});
  //   });
  // }

  @override
  // ignore: must_call_super
  void initState() {
    // getImage();
  }
  void searchData(String query) {}

  List houses = [
    'assets/images/house1.png',
    'assets/images/house2.png',
    'assets/images/house3.png',
    'assets/images/house1.png',
  ];

  List address = [
    'House # 12345, St # 88, Sec # 7....',
    'House # 12345, St # 88, Sec # 7....',
    'House # 12345, St # 88, Sec # 7....',
    'House # 12345, St # 88, Sec # 7....',
  ];
  var _url;
  // getImage() {
  //   final ref = FirebaseStorage.instance
  //       .ref('Property/')
  //       .child('image_picker8294153886355980194.jpg');
  //   var url = ref.getDownloadURL();
  //   print(url);
  //   _url = url;
  //   return _url;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text('Real Estate'),
        ),
      ),
      body: Column(
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
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('Addresses')
                  .orderByKey()
                  .limitToLast(10)
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetail(
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

          // Expanded(
          //   child: Container(
          //     child: ListView.builder(
          //       itemCount: houses.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PropertyDetail(
          //       image: houses[index],
          //       address: address[index],
          //     ),
          //   ),
          // );
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Container(
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border.all(color: Colors.grey),
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         blurRadius: 4,
          //         offset: Offset(0, 4),
          //       )
          //     ]),
          // height: size.height * 0.11,
          //               child: Center(
          //                 child: ListTile(
          //                   leading: CircleAvatar(
          //                     backgroundColor: Colors.white,
          //                     radius: 30,
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(
          //                         top: 8.0,
          //                         bottom: 8.0,
          //                       ),
          //                       child: Image(
          //                         image: AssetImage(
          //                           houses[index],
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   title: Text(
          //                     address[index],
          //                     style: TextStyle(
          //                       fontSize: 17,
          //                       color: Colors.grey[600],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
