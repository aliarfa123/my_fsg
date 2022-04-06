import 'dart:io';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class GeneratePDF extends StatefulWidget {
  var image2;
  var address2;
  var name;
  var contact;
  var email;
  var tel;
  GeneratePDF({
    Key? key,
    this.image2,
    this.address2,
    this.name,
    this.contact,
    this.email,
    this.tel,
  }) : super(key: key);

  @override
  State<GeneratePDF> createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  final netImage = NetworkImage('https://www.nfet.net/nfet.jpg');

  final pdf = pw.Document();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      var networkImg = widget.image2;
    });
  }

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
                    image: NetworkImage(widget.image2),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: size.width * 0.45,
                child: Wrap(
                  children: [
                    Text(
                      widget.address2,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
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
                  'Name:  ' + widget.name.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact:   ' + widget.contact.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tel:   ' + widget.tel.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email:   ' + widget.email.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            onTap: () async {
              final pdfFile = await PdfApi.generateImage(
                  widget.image2.toString(),
                  widget.address2.toString(),
                  widget.name.toString(),
                  widget.contact.toString(),
                  widget.tel.toString(),
                  widget.email.toString());
              PdfApi.openFile(pdfFile);
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}

class PdfApi {
  static Future<File> generateImage(
      String img, address, name, contact, tel, email) async {
    final pdf = pw.Document();
    final netImage = await networkImage(img);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  // width: 500,
                  height: 300,
                  child: pw.Image(netImage),
                ),
                pw.Text(
                  'Adress:  ' + address.toString(),
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Name:    ' + name.toString(),
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Contact: ' + contact.toString(),
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Tel:     ' + tel.toString(),
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Email:   ' + email.toString(),
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ]); // Center
        }));
    return saveDocument(name: 'MyFsg.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
