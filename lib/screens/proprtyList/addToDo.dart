import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:my_fsg/screens/proprtyList/todolist.dart';
import 'package:my_fsg/theme/colors.dart';

// ignore: must_be_immutable
class AddToDo extends StatefulWidget {
  var address;
  AddToDo({Key? key, this.address}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<File> images = [];
  DatabaseReference db = FirebaseDatabase.instance.ref();
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  putImage(List<XFile> image_list, String pushKey) async {
    for (int i = 0; i <= image_list.length; i++) {
      String imageurl;
      final destination = 'To Do/${address}';
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(image_list[i].name);
      File imageFile = File(image_list[i].path);
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        imageurl = await uploadTask.snapshot.ref.getDownloadURL();
        db
            .child('To Do')
            .child(address.toString())
            .child(pushKey)
            .child('Images')
            .push()
            .set(imageurl);
        print(imageurl);
      });
    }
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? address;
  @override
  void initState() {
    super.initState();
    setState(() {
      address = widget.address.toString();
    });
  }

  setData(
    String title,
    dynamic desc,
    String date,
    String pushKey,
  ) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('To Do')
        .child(address.toString())
        .child(pushKey);
    await ref.set({
      'Title': title,
      "Desc": desc,
      "Date": date,
      "Approved": 'false',
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     children: List.generate(images.length, (index) {
  //       Asset asset = images[index];
  //       return Padding(
  //         padding: const EdgeInsets.all(6.0),
  //         child: AssetThumb(
  //           asset: asset,
  //           width: 300,
  //           height: 300,
  //         ),
  //       );
  //     }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // Future<void> loadAssets() async {
    //   List<Asset> resultList = <Asset>[];
    //   String error = 'No Error Detected';

    //   try {
    //     resultList = await MultiImagePicker.pickImages(
    //       maxImages: 10,
    //       enableCamera: true,
    //       selectedAssets: images,
    //       cupertinoOptions: CupertinoOptions(
    //         takePhotoIcon: "chat",
    //         doneButtonTitle: "Fatto",
    //       ),
    //       materialOptions: MaterialOptions(
    //         actionBarColor: "#28c662",
    //         actionBarTitle: "My FSG",
    //         allViewTitle: "All Photos",
    //         useDetailsView: false,
    //         selectCircleStrokeColor: "#28c662",
    //       ),
    //     );
    //   } on Exception catch (e) {
    //     error = e.toString();
    //   }

    //   if (!mounted) return;

    //   setState(() {
    //     images = resultList;
    //     _error = error;
    //   });
    // }

    // final format = DateFormat("yyyy-MM-dd");
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
                  controller: titleController,
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
                  controller: descController,
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
                  controller: dateController,
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
                          child: imagefiles != null
                              ? Wrap(
                                  children: imagefiles!.map((imageone) {
                                    return Container(
                                        child: Card(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.file(File(imageone.path)),
                                      ),
                                    ));
                                  }).toList(),
                                )
                              : Container(
                                  child: Text('Pick Images'),
                                ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            openImages();
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
                  onTap: () {
                    DatabaseReference db = FirebaseDatabase.instance.ref();
                    String pushKey = db.push().key.toString();
                    putImage(imagefiles!, pushKey);
                    setData(titleController.text, descController.text,
                        selectedDate.toString(), pushKey);
                    setState(() {
                      titleController.clear();
                      descController.clear();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Added Successfully'),
                            );
                          });
                    });
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
