import 'package:firebase_database/firebase_database.dart';
import 'package:my_fsg/screens/pdfcomp.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> generateImage(
      String img, address, name, contact, tel, email) async {
    final pdf = Document();
    final netImage = await networkImage(img);
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 500,
                  height: 300,
                  child: Image(netImage),
                ),
                Text(
                  'Adress:  ' + address.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Name:    ' + name.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Contact: ' + contact.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tel:     ' + tel.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Email:   ' + email.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Notes:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]); // Center
        }));
    return saveDocument(name: 'MyFsg.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
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
