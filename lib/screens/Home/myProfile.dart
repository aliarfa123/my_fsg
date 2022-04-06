import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fsg/theme/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MyProfile extends StatefulWidget {
  var email;
  MyProfile({Key? key, this.email}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController updateName = TextEditingController();
  TextEditingController updateTel = TextEditingController();
  TextEditingController updateemail = TextEditingController();

  var email;
  var tel;
  var name;
  var _url;
  getImage() async {
    final ref = FirebaseStorage.instance
        .ref('Sign Up/' + widget.email.toString().replaceAll('.com', ''))
        .child('Logo');
    var url = await ref.getDownloadURL();
    print(url);
    setState(() {
      _url = url;
    });
  }

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

  final ImagePicker _picker = ImagePicker();
  var _image;
  putImage(String email) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    String imageurl;
    if (_image == null) return;
    final destination = 'Sign Up/' + email.replaceAll('.com', '');
    final ref = firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .child('Logo');
    firebase_storage.UploadTask uploadTask = ref.putFile(_image);
    return uploadTask;
    // await uploadTask.whenComplete(() async {
    //   imageurl = await uploadTask.snapshot.ref.getDownloadURL();
    //   db.child('Customers').child(pushKey).child('image_link').set(imageurl);
    //   print(imageurl);
    // });
    // ref.putFile(_image!);
  }

  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
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
  // ignore: must_call_super
  void initState() {
    readData();
    readName();
    readTel();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Center(
          child: Text('My Profile'),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            height: size.height * 0.3,
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size.height * 0.07,
                    child: Image(
                      image: NetworkImage(_url),
                      height: size.height * 0.1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      _getFromGallery();
                      setState(() {
                        putImage(widget.email.toString());
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: updateName,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(color: primary)),
                                    labelText: 'Update Name',
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
                                  final db = FirebaseDatabase.instance.ref(
                                    widget.email
                                        .toString()
                                        .replaceAll('.com', ''),
                                  );

                                  db.update({'name': updateName.text}).then(
                                    (value) => {
                                      updateName.clear(),
                                      Navigator.pop(context)
                                    },
                                  );
                                },
                                child: Text('Update Name'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tel,
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: updateTel,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(color: primary)),
                                    labelText: 'Update Phone Number',
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
                                  final db = FirebaseDatabase.instance.ref(
                                    widget.email
                                        .toString()
                                        .replaceAll('.com', ''),
                                  );

                                  db.update({'telephone': updateTel.text}).then(
                                    (value) => {
                                      updateName.clear(),
                                      Navigator.pop(context)
                                    },
                                  );
                                },
                                child: Text('Update Phone Number'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.email,
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: updateemail,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(color: primary)),
                                    labelText: 'Update Email',
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
                                  final db = FirebaseDatabase.instance.ref(
                                    widget.email
                                        .toString()
                                        .replaceAll('.com', ''),
                                  );

                                  db.update({'email': updateemail.text}).then(
                                    (value) => {
                                      updateName.clear(),
                                      Navigator.pop(context)
                                    },
                                  );
                                },
                                child: Text('Update Email'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
