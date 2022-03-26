import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/login.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/colors.dart';
import 'bottomNavBar.dart';
import 'bottomNavBar2.dart';

class SignUp extends StatefulWidget {
  bool admin;
  bool cust;
  SignUp({Key? key, this.admin = false, this.cust = true}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ImagePicker _picker = ImagePicker();
  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  var _image;

  // Future getImagefromGallery() async {
  //   File? image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primary,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                              // getImagefromGallery();
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
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyLogin(),
                                        ),
                                      ),
                                    );
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
                        Text(
                          "Already Have account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        // const SizedBox(height: 15.0),
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
