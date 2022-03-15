import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Selection.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (ctx, timer) => timer.connectionState == ConnectionState.done
            ? SelectionPage()
            : Container(
                color: Colors.white,
                child: Center(
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.42,
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
