import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  var email;
  Approval({Key? key, required this.email}) : super(key: key);

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  var email;
  readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance
        .ref(widget.email.toString().replaceAll('.com', '') + '/email');
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        email = data;
      });
      print(widget.email);
      return widget.email;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Approved'),
      ),
    );
  }
}
