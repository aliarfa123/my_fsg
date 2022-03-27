import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class MyProfile extends StatefulWidget {
  var email;
  MyProfile({Key? key, this.email}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var email;
  var tel;
  var name;
  readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance
        .ref(widget.email.toString().replaceAll('.com', '') + '/email');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        email = data;
      });
      print(email);
      return email;
    });
  }

  readName() async {
    DatabaseReference databaseref = FirebaseDatabase.instance
        .ref(widget.email.toString().replaceAll('.com', '') + '/name');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        name = data;
      });
      print(name);
      return name;
    });
  }

  readTel() async {
    DatabaseReference databaseref = FirebaseDatabase.instance
        .ref(widget.email.toString().replaceAll('.com', '') + '/telephone');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        tel = data;
      });
      print(tel);
      return tel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readData();
    readName();
    readTel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text('My Profile'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Logo',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              tel ,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.email,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
