import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import 'package:my_fsg/screens/Selection.dart';
import 'package:my_fsg/screens/bottomNavBar.dart';
import 'package:my_fsg/screens/login.dart';
import 'package:my_fsg/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: const SelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
