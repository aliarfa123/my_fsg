import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance
        .ref();
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        // email = data;
      });
    });
  }
  TextEditingController adressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text('Add Property'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: adressController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: primary)),
                labelText: 'Address',
                fillColor: Colors.grey.shade100,
                filled: true,
                focusColor: primary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              db
                  .child('Addresses')
                  .push()
                  .child('Adress')
                  .set(adressController.text);
            },
            child: Text(
              'Add',
            ),
          )
        ],
      ),
    );
  }
}
