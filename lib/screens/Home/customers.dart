import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(child: Text('Customers')),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('Customers')
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
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PropertyDetail(
                          //       image: nextAdress['image_link'].toString(),
                          //       address: nextAdress['Address'].toString(),
                          //     ),
                          //   ),
                          // );
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
                                nextAdress['name'].toString(),
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

            // child: Container(
            //   child: ListView.builder(
            //     itemCount: houses.length,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {},
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 border: Border.all(color: Colors.grey),
            //                 borderRadius: BorderRadius.circular(10),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.5),
            //                     blurRadius: 4,
            //                     offset: Offset(0, 4),
            //                   )
            //                 ]),
            //             height: size.height * 0.11,
            //             child: Center(
            //               child: ListTile(
            //                 leading: Container(
            //                   height: 50,
            //                   width: 50,
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(20),
            //                       image: DecorationImage(
            //                         image: AssetImage(
            //                           houses[index],
            //                         ),
            //                       )),
            //                   // child:
            //                   // Padding(
            //                   //   padding: const EdgeInsets.only(
            //                   //     top: 2,
            //                   //     bottom: 2,
            //                   //   ),
            //                   //   child: Image(
            //                   //     image: AssetImage(
            //                   //       houses[index],
            //                   //     ),
            //                   //   ),
            //                   // ),
            //                 ),
            //                 title: Text(
            //                   address[index],
            //                   style: TextStyle(
            //                     fontSize: 17,
            //                     color: Colors.grey[600],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                              ),
                              AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Customer',
                                      style: TextStyle(color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.close,
                                          color: primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Name of the firm',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Name of the contact person',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Real estate of the customer',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Telephone',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: primary)),
                                      labelText: 'Email',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusColor: primary,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      color: primary,
                                      child: Center(
                                        child: Text(
                                          'Add Customer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  width: size.width * 0.15,
                  image: AssetImage('assets/images/Plus.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
