import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fsg/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    // print(ref.getDownloadURL());
    // uploadTask.then(() {
    //   imageurl = ref.getDownloadURL().toString();
    //   print(imageurl);
    //   // print(ref.getDownloadURL());
    //   db.child('Addresses').child(pushKey).child('image_link').set(imageurl);
    //   // print(imageurl);
    // }).catchError((onError) {
    //   print(onError);
    // });
    // return imageurl;
    // uploadTask
    //     .whenComplete(() => {
    //           db
    //               .child('Addresses')
    //               .push()
    //               .child('imageLink')
    //               .set(ref.getDownloadURL()),
    //         })
    //     .catchError((onError) {
    //   print(onError);
    // });

    // uploadTask.then((res) => {
    //       // print(ref.getDownloadURL()),
    //       db
    //           .child('Addresses')
    //           .push()
    //           .child('imageLink')
    //           .set(res.ref.getDownloadURL()),
    //     });
  }

  readData() async {
    DatabaseReference databaseref = FirebaseDatabase.instance.ref();
    databaseref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }

  TextEditingController adressController = TextEditingController();
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
          ElevatedButton(
            onPressed: () {
              String pushKey = db.push().key.toString();
              db
                  .child('Addresses')
                  .child(pushKey)
                  .child('Address')
                  .set(adressController.text);
              putImage(pushKey);
            },
            child: Text(
              'Add',
            ),
          ),
        ],
      ),
    );
  }
}
