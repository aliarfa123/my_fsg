import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SendImagesToFirebase extends StatefulWidget {
  const SendImagesToFirebase({Key? key}) : super(key: key);

  @override
  State<SendImagesToFirebase> createState() => _SendImagesToFirebaseState();
}

class _SendImagesToFirebaseState extends State<SendImagesToFirebase> {
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

  putImage(List<XFile> image_list) async {
    for (int i = 0; i <= image_list.length; i++) {
      String imageurl;
      final destination = 'Property';
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(image_list[0].name);
      File imageFile = File(image_list[i].path);
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        imageurl = await uploadTask.snapshot.ref.getDownloadURL();
        db.child('pushed_images').push().set(imageurl);
        print(imageurl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Multiple Image Picker Flutter"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //open button ----------------
              ElevatedButton(
                  onPressed: () {
                    openImages();
                  },
                  child: Text("Open Images")),

              Divider(),
              ElevatedButton(
                  onPressed: () {
                    // images.add(File(imagefiles![0].path));
                    putImage(imagefiles!);
                  },
                  child: Text("Upload Images")),

              Divider(),
              Text("Picked Files:"),
              Divider(),

              imagefiles != null
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
                  : Container()
            ],
          ),
        ));
  }
}
