import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class ToDoDetail extends StatefulWidget {
  var address;
  var title;
  var desc;
  var date;
  ToDoDetail({Key? key, this.title, this.desc, this.date, this.address})
      : super(key: key);

  @override
  State<ToDoDetail> createState() => _ToDoDetailState();
}

class _ToDoDetailState extends State<ToDoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('To Do Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'Date: ' + widget.date.toString().split(' ').first,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Wrap(
              children: [
                Text(
                  widget.title + ' - ' + widget.address,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                Text(
                  'Description: ' + widget.desc,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Images:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
