import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/Selection.dart';
import 'package:my_fsg/screens/SignUp.dart';
import 'package:my_fsg/screens/bottomNavBar.dart';
import 'package:my_fsg/screens/login.dart';
import 'package:my_fsg/screens/proprtyList/addToDo.dart';
import 'package:my_fsg/screens/proprtyList/noteslist.dart';
import 'package:my_fsg/screens/splash.dart';
import 'package:my_fsg/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'AnekTamil',
        primaryColor: primary,
      ),
      home: SelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
