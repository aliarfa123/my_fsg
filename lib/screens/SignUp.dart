import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../theme/colors.dart';
import 'bottomNavBar.dart';
import 'bottomNavBar2.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  bool admin;
  bool back;
  bool cust;
  SignUp({Key? key, this.admin = false, this.cust = true, this.back = false})
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  DatabaseReference db = FirebaseDatabase.instance.ref();
  final ImagePicker _picker = ImagePicker();
  var _image;
  putImage(String email, String pushKey) async {
    String imageurl;
    if (_image == null) return;
    final destination = 'Sign Up/' + email.replaceAll('.com', '');
    final ref = firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .child('Logo');
    firebase_storage.UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() async {
      imageurl = await uploadTask.snapshot.ref.getDownloadURL();
      db.child('Customers').child(pushKey).child('image_link').set(imageurl);
      print(imageurl);
    });
    // ref.putFile(_image!);
  }

  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  setData(
    String email,
    dynamic tel,
    String name,
    String pushKey,
  ) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('Customers').child(pushKey);
    await ref.set({
      'email': email,
      "telephone": tel,
      "name": name,
      "Approved": 'false',
    });
  }

  setData2(
    String email,
    dynamic tel,
    String name,
  ) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref(email.toString().replaceAll('.com', '').replaceAll('"', ''));
    await ref.set({
      'email': email,
      "telephone": tel,
      "name": name,
    });
  }

  // Future getImagefromGallery() async {
  //   File? image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    createUser(String email, String pass) async {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyLogin(),
              ),
            ),
          );
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.back == true)
              Row(
                children: [
                  SafeArea(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
                ],
              )
            else
              Container(),
            if (widget.back == true)
              SizedBox(
                height: size.height * 0.04,
              )
            else
              SizedBox(
                height: size.height * 0.1,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.back == true)
                  Container(
                    child: Text(
                      'Add Customer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primary,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Container(
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primary,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              width: size.width * 0.9,
              child: Column(
                children: [
                  TextFormField(
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
                  const SizedBox(height: 20.0),
                  TextFormField(
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
                  const SizedBox(height: 20.0),
                  TextFormField(
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
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: primary)),
                      labelText: 'Password',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      focusColor: primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    controller: confirmPass,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: primary)),
                      labelText: 'Confirm Password',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      focusColor: primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: size.height * 0.2,
                    width: double.infinity,
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
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.7)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                String pushKey = db.push().key.toString();
                                if (emailController.text.contains('@') &&
                                    // emailController.text.contains('.com') &&
                                    nameController.text.isNotEmpty &&
                                    passwordController.text ==
                                        confirmPass.text &&
                                    passwordController.text.length > 6 &&
                                    telController.text.isNotEmpty) {
                                  putImage(emailController.text, pushKey);
                                  setData(
                                      emailController.text,
                                      telController.text,
                                      nameController.text,
                                      pushKey);
                                  setData2(
                                    emailController.text,
                                    telController.text,
                                    nameController.text,
                                  );
                                  createUser(emailController.text,
                                          passwordController.text)
                                      .then(
                                    (value) => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Center(
                                                child: Text(
                                                  'Sign Up Successful',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: primary,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Center(
                                              child: Text(
                                                'Please fill the form correctly',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.6,
                                image: const AssetImage(
                                  'assets/images/signup.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (widget.back == true)
                          Container()
                        else
                          Text(
                            "Already Have account?",
                            style: TextStyle(fontSize: 15),
                          ),
                        // const SizedBox(height: 15.0),
                        if (widget.back == true)
                          Container()
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyLogin(
                                        admin: widget.admin,
                                        cust: widget.cust,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "LogIn",
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
