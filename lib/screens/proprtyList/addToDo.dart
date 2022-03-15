import 'dart:io';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:my_fsg/screens/proprtyList/todolist.dart';
import 'package:my_fsg/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  String? title;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  var _image;

  Future getImagefromGallery() async {
    // ignore: deprecated_member_use
    File? image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: primary,
        title: Text('Add To do List'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (value) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('title', value);
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: primary)),
                    labelText: 'Title',
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
                    labelText: 'Description',
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
                    labelText: "${selectedDate.toLocal()}".split(' ')[0],
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    focusColor: primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context);
                  },
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                            getImagefromGallery();
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
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    //Return String
                    title = prefs.getString('title');
                    print(title);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToDoList(title: title),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primary,
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
