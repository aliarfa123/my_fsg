import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseExample extends StatefulWidget {
  const FirebaseExample({Key? key}) : super(key: key);

  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  TextEditingController name = TextEditingController();

  dynamic data1;
  createDB(String name) {
    databaseReference.child('user').child('name').set(name);
  }

  setData(String name, int age) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('user');

    await ref.set({
      "name": name,
      "age": age,
    });
  }

  void readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref('user/name');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        data1 = data;
      });
    });
    // databaseReference.once().then(((value) {}));
    // await databaseReference.once().then((value) {
    //   Map<dynamic, dynamic>.from(value).forEach((key, values) {});
    // });
  }

  @override
  // ignore: must_call_super
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: name),
        actions: [
          IconButton(
            onPressed: () {
              createDB(name.text);
              // setData(name.text, 19);
              readData();
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Text(data1.toString()),
    );
  }

  // Future createUser({required String name}) async {
  //   final docUser = FirebaseFirestore.instance.collection('Users').doc('my-id');

  //   final json = {
  //     'name' = name,

  //   };
  //   await docUser.set(json);
  // }
}
