import 'package:flutter/material.dart';
import 'package:my_fsg/screens/login.dart';
import 'package:my_fsg/theme/colors.dart';
import 'package:my_fsg/theme/textstyle.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  bool admin = false;
  bool cust = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Role:',
                  style: bigTextBlack,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (cust == true) {
                        admin = false;
                      } else
                        admin = !admin;
                    });
                  },
                  child: Image(
                    image: admin
                        ? AssetImage('assets/images/admin_green.png')
                        : AssetImage('assets/images/admin_white.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    if (admin == true) {
                      cust = false;
                    } else
                      cust = !cust;
                  }),
                  child: Image(
                    image: cust
                        ? AssetImage('assets/images/cust_green.png')
                        : AssetImage('assets/images/cust_white.png'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                backgroundColor: primary,
                onPressed: () {
                  // if (cust == true && admin == true ||
                  //     cust == false && admin == false) {
                  //   showDialog(
                  //       context: context,
                  //       builder: (_) => AlertDialog(
                  //             backgroundColor: primary,
                  //             title: Text('Please select one option'),
                  //           ));
                  // } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyLogin(
                        admin: admin,
                        cust: cust,
                      ),
                    ),
                  );
                },
                // },
                child: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
