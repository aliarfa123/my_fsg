import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fsg/theme/colors.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  var _image;
  var imageName;
  var imagePath;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference db = FirebaseDatabase.instance.ref();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
      imagePath = _image.path;
      imageName = _image.path.split('/').last;
    });
  }

  putImage(String pushKey) async {
    String imageurl;
    // if (_image == null) return;
    final destination = 'Property';
    final ref = firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .child(imageName);
    firebase_storage.UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() async {
      imageurl = await uploadTask.snapshot.ref.getDownloadURL();
      db.child('Addresses').child(pushKey).child('image_link').set(imageurl);
      print(imageurl);
    });
  }

  readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref();
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }

  TextEditingController adressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text('Add Property'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Property',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Name',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contactController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Contact',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Email',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: telController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Tel',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: _image == null
                          ? Center(
                              child: Text(
                                "Pick an Image",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.image),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Notes',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Title',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: primary)),
                  labelText: 'Description',
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusColor: primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add To Do's",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (adressController.text.isNotEmpty &&
                    nameController.text.isNotEmpty &&
                    contactController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    telController.text.isNotEmpty &&
                    notesController.text.isNotEmpty &&
                    descController.text.isNotEmpty &&
                    _image != null) {
                  String pushKey = db.push().key.toString();
                  db
                      .child('Addresses')
                      .child(pushKey)
                      .child('Address')
                      .set(adressController.text);
                  db
                      .child('Notes')
                      .child(adressController.text)
                      .child(pushKey)
                      .child('Title')
                      .set(notesController.text);
                  db
                      .child('Notes')
                      .child(adressController.text)
                      .child(pushKey)
                      .child('Desc')
                      .set(descController.text);
                  db
                      .child('Addresses')
                      .child(pushKey)
                      .child('Name')
                      .set(nameController.text);
                  db
                      .child('Addresses')
                      .child(pushKey)
                      .child('Contact')
                      .set(contactController.text);
                  db
                      .child('Addresses')
                      .child(pushKey)
                      .child('Email')
                      .set(emailController.text);
                  db
                      .child('Addresses')
                      .child(pushKey)
                      .child('Tel')
                      .set(telController.text);
                  putImage(pushKey);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Form Filled Successfully'),
                        );
                      });
                  setState(() {
                    adressController.clear();
                    descController.clear();
                    contactController.clear();
                    emailController.clear();
                    nameController.clear();
                    telController.clear();
                    notesController.clear();
                    _image = null;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Please Fill all the form fields'),
                        );
                      });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: size.width * 0.3,
                height: size.height * 0.06,
                child: Center(
                  child: Text(
                    'Add',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
