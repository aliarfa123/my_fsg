import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class GeneratePDF extends StatefulWidget {
  var image2;
  var address2;
  GeneratePDF({Key? key, this.image2, this.address2}) : super(key: key);

  @override
  State<GeneratePDF> createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Generate PDF'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  // color: primary,
                  image: DecorationImage(
                      image: AssetImage(widget.image2), fit: BoxFit.fill),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: size.width * 0.45,
                child: Wrap(
                  children: [
                    Text(widget.address2),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Details:',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name:       ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact:    ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email:        ________________',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Generate PDF',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
