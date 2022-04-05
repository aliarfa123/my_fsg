import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Selection.dart';
import 'package:my_fsg/screens/SignUp.dart';
import 'package:my_fsg/screens/bottomNavBar.dart';
import 'package:my_fsg/screens/bottomNavBar2.dart';
import 'package:my_fsg/theme/colors.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  Future<FirebaseApp> _firebaseInit() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyLogin();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class MyLogin extends StatefulWidget {
  bool admin;
  bool cust;
  MyLogin({Key? key, this.admin = false, this.cust = true}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                    ),
                    child: Text(
                      widget.admin == true ? 'Log In' : 'Log In/Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primary,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
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
                      const SizedBox(height: 30.0),
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
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (emailController.text.toLowerCase() ==
                                      'myfsg000@gmail.com' &&
                                  passwordController.text == '123abc??') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RootApp(
                                      email: emailController.text,
                                    ),
                                  ),
                                );
                              } else {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RootAppCust(
                                            email: emailController.text,
                                          ),
                                        ),
                                      ),
                                    )
                                    .onError(
                                      (error, stackTrace) => showDialog(
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
                                                    'Please enter valid Email and Password',
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
                              }
                            },
                            child: Image(
                              width: MediaQuery.of(context).size.width * 0.6,
                              image: const AssetImage(
                                'assets/images/login.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.admin == false)
                        Column(
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              "Already Have account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(
                                          admin: widget.admin,
                                          cust: widget.cust,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: primary,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<User?> logInWithEmailPass(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      }
    }
    return user;
  }

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
